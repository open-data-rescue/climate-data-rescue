#
module LedgerUtils
  extend ActiveSupport::Concern

  #
  #  Split the filename of the upoad into the parts needed to identify
  #  the ledger, volume etc
  #
  def parse_filename(filename:)
    components = filename.split("_")

    raise "invalid filename" unless [5,6].include?(components.count)

    if components.count == 6 # Normal DRAW app
      {
        accession_number: components[0],
        ledger_type:      components[1],
        volume:           components[2],
        start_date:       Date.parse(components[3]),
        end_date:         Date.parse(components[4]),
        page_type_num:    components[5].blank? ? nil : components[5][0],
        page_title:       "#{components[3]} to #{components[4]}"
      }
    elsif components.count == 5 #ECCC data
      page_types = components[4].split(".")
      page_type_num = page_types[0]
      start_date = Date.parse(components[3])

      {
        accession_number: components[0],
        ledger_type:      components[1],
        volume:           components[2],
        start_date:       start_date,
        end_date:         start_date.next_month.prev_day,
        page_type_num:    page_type_num,
        page_title:       "#{components[0]} - #{start_date} to #{end_date}"
      }
    end
  end

  #
  # Find the ledger, if not present create a new one
  #
  def create_or_find_ledger(components:)
    raise "Unable to find or create Ledger" unless components[:ledger_type]

    # Logic to ensure only one ledger of given type (because DB does not have constraint)
    ledger = Ledger.find_by(ledger_type: components[:ledger_type])

    if !ledger
      Ledger.with_advisory_lock("Ledger_#{components[:ledger_type]}_lock", timeout_seconds: 60) do
        Ledger.transaction do
          ledger = Ledger.find_or_create_by(ledger_type: components[:ledger_type]) do |ledger|
            ledger.title = components[:ledger_type]
          end
        end
      end
    end

    ledger
  end

  #
  # Find the page type, if not present create a new one
  #
  def create_or_find_page_type(ledger:, components:)
    raise "Unable to find or create PageType" unless ledger && components[:page_type_num]

    # Logic to ensure only one PageType of given type (because DB does not have constraint)
    page_type = PageType.find_by(number: components[:page_type_num], ledger_id: ledger.id)

    if !page_type
      PageType.with_advisory_lock("PageType_#{components[:page_type_num]}_#{ledger.id}_lock", timeout_seconds: 60) do
        PageType.transaction do
          page_type = PageType.find_or_create_by(number: components[:page_type_num], ledger_id: ledger.id) do |pt|
            pt.ledger_type = components[:ledger_type]
            pt.title = "Register #{components[:ledger_type]}, page #{components[:page_type_num]}"
          end
        end
      end
    end

    page_type
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
  def create_page(image:, ledger:, page_type:, components:)
    raise "no image for page" if image.blank?
    raise "duplicate page" if Page.where("image_file_name like ?", "#{filename_sans_suffix(image: image)}.%").count > 0

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
