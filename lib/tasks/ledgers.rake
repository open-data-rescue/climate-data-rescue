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
  # => :environment
  task :move_pages, [:from, :to] do |t, args|
    # from_id = args[:from_id]
    options = {}
    opts = OptionParser.new
    opts.banner = "Usage: rake add [options]"
    opts.on("-f", "--from ARG", Integer) { |from| options[:from] = from }
    opts.on("-t", "--to ARG", Integer) { |to| options[:to] = to }
    args = opts.order!(ARGV) {}
    options.each { |n, a| task a.to_sym do ; end }
    opts.parse!(args)

    # puts ARGV

    puts "** t #{t}"
    puts "** args #{options}"

    # from page type id to page type id
    # check tha the titles for from and to are the same
  end

  # move page type to ledger
  task :move_page_type => :environment do
  end
end
