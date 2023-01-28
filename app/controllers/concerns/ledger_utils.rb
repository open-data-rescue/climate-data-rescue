#
module LedgerUtils
  extend ActiveSupport::Concern

  #
  #  Split the filename of the upoad into the parts needed to identify
  #  the ledger, volume etc
  #
  def parse_filename(filename:)
    components = filename.split("_")

    raise "invalid filename" unless components.count == 6

    {
      accession_number: components[0],
      ledger_type:      components[1],
      volume:           components[2],
      start_date:       Date.parse(components[3]),
      end_date:         Date.parse(components[4]),
      page_type_num:    components[5].blank? ? nil : components[5][0],
      page_title:       "#{components[3]} to #{components[4]}"
    }
  end

  #
  # Find the ledger, if not present create a new one
  #
  def create_or_find_ledger(components:)
    return nil unless components[:ledger_type]

    Ledger.find_or_create_by(ledger_type: components[:ledger_type]) do |ledger|
      ledger.title = components[:ledger_type]
    end
  end

  #
  # Find the page type, if not present create a new one
  #
  def create_or_find_page_type(ledger:, components:)
    return nil unless ledger && components[:page_type_num]

    PageType.find_or_create_by(number: components[:page_type_num], ledger_id: ledger.id) do |page_type|
      page_type.ledger_type = components[:ledger_type]
      page_type.title = "Register #{components[:ledger_type]}, page #{components[:page_type_num]}"
    end
  end

  #
  # Get the file name of the image without the suffix,
  # so 1491_340_11_1879-08-09_1879-08-11_2.jpg and 1491_340_11_1879-08-09_1879-08-11_2.jpeg
  # will refer to the same page
  #
  def filename_sans_suffix(image:)
    image.original_filename.rpartition('.').first.strip
  end

  #
  # Create a page if it does not exist
  #
  def create_page(image:)
    return if image.blank?

    raise "duplicate page" if Page.where("image_file_name like ?", "#{filename_sans_suffix(image: image)}.%").count > 0

    components = parse_filename(filename: filename_sans_suffix(image: image))
    ledger = create_or_find_ledger(components: components)
    page_type = create_or_find_page_type(ledger: ledger, components: components)

    page = Page.new(
             image: image,
             visible: false,
             page_type: page_type
           )

    set_from_component(page: page, components: components)

    page.save!

    page
  end

  #
  # Set the page attributes based on the components parsed from the filename
  #
  def set_from_component(page:, components:)
    return false unless page && components

    # page_type
    page.accession_number = components[:accession_number]
    page.volume = components[:volume]
    page.start_date = components[:start_date]
    page.end_date = components[:end_date]

    page.title = components[:page_title]

    page
  end
end
