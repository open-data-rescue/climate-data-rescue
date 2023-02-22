#
require 'optparse'

namespace :ledgers do
  desc "Counts number of ledgers for each type"
  task :dup_ledgers => :environment do
    counts = ::Ledger.group(:ledger_type).count
    counts.each do |ledger_type, count|
      if count > 1
        puts "Ledger #{ledger_type} has #{count} instance(s)"
        ledgers = ::Ledger.where ledger_type: ledger_type
        ledgers.each do |l|
          puts "  id #{l.id} has #{l.page_types.count} page types and #{l.pages.count} pages"
          l.page_types.each do |pt|
            puts "    page type id #{pt.id} with title #{pt.title} has #{pt.pages.count} pages with #{pt.transcriptions.count} transcriptions with #{pt.annotations.count} annotations"
          end
        end
      end
    end
  end

  # Find dup page types and their data (pages)
  task :dup_page_types => :environment do
    counts = ::PageType.group(:title).count
    counts.each do |title, count|
      if count > 1
        puts "Page Type #{title} has #{count} instance(s)"
        page_types = ::PageType.where title: title
        page_types.each do |pt|
          puts "  id #{pt.id} from ledger #{pt.ledger.id} has #{pt.pages.count} pages with #{pt.transcriptions.count} transcriptions with #{pt.annotations.count} annotations"
        end
      end
    end
  end

  # move pages from page type 1 to page type
  task :move_pages => :environment do |t, args|
    options = process_options(
                banner: "Usage: rake move_pages [options]",
                args: args,
                opts: [
                  {desc: ["-f", "--from ARG", Integer], option: :from},
                  {desc: ["-t", "--to ARG", Integer], option: :to}
                ]
              )

    puts "** args #{options}"

    # from page type id to page type id
    # check tha the titles for from and to are the same
  end

  # move page type to ledger
  task :move_page_type => :environment do  |t, args|
    options = process_options(
                banner: "Usage: rake move_page_type [options]",
                args: args,
                opts: [
                  {desc: ["-p", "--page_type ARG", Integer], option: :page_type},
                  {desc: ["-l", "--ledger ARG", Integer], option: :ledger}
                ]
              )
    # puts "** args #{options}"

    # Get the page type
    # Check that the ledger name works
    pageType = PageType.find options[:page_type]
    ledger = Ledger.find options[:ledger]

    raise "no valid page type" unless pageType
    raise "no valid ledger" unless ledger
    raise "Ledger type does not match" unless ledger.ledger_type == pageType.ledger_type

    pageType.ledger_id = ledger.id
    pageType.save!

    puts "* Moved #{pageType.id} - #{pageType.title} to Ledger #{ledger.id}"
  end

  task :merge_page_types => :environment do  |t, args|
    options = process_options(
                banner: "Usage: rake merge_page_types [options]",
                args: args,
                opts: [
                  {desc: ["-p", "--from ARG", Integer], option: :from},
                  {desc: ["-l", "--to ARG", Integer], option: :to}
                ]
              )

    from = PageType.find options[:from]
    to = PageType.find options[:to]

    raise "no valid from page type" unless from
    raise "no valid to page type" unless to
    raise "the page numbers do not match" unless to.number == from.number
    raise "the ledger types do not match" unless to.ledger_type == from.ledger_type

    moving_count = from.pages.count

    puts "Moving #{moving_count} pages"
    PageType.transaction do
      from.pages.update_all(page_type_id: to.id)
      from.destroy
      puts "Moved #{moving_count} pages"
    end
  end

  task :merge_ledgers => :environment do  |t, args|
    options = process_options(
                banner: "Usage: rake merge_ledgers [options]",
                args: args,
                opts: [
                  {desc: ["-p", "--from ARG", Integer], option: :from},
                  {desc: ["-l", "--to ARG", Integer], option: :to}
                ]
              )

    from = Ledger.find options[:from]
    to = Ledger.find options[:to]

    raise "no valid from ledger" unless from
    raise "no valid to ledger" unless to
    raise "the ledger types do not match" unless to.ledger_type == from.ledger_type

    moving_count = from.page_types.count

    puts "Moving #{moving_count} page types"
    Ledger.transaction do
      from.page_types.update_all(ledger_id: to.id)
      from.destroy
      puts "Moved #{moving_count} page types"
    end
  end

  # Process args from the command line
  def process_options(banner:, args:, opts:)
    options = {}
    opts_parser = OptionParser.new
    opts_parser.banner = banner
    opts.each do |opt|
      opts_parser.on(*opt[:desc]) { |v| options[opt[:option]] = v }
    end
    opts_parser.parse!(opts_parser.order!(args) {})
    options.each { |n, a| task a.to_s.to_sym do ; end }

    options
  end
end
