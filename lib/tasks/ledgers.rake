#
namespace :ledgers do
  desc "Counts number of ledgers for each type"
  task :dup_ledgers => :environment do
    counts = ::Ledger.group(:ledger_type).count
    counts.each do |ledger_id, count|
      p "Ledger #{ledger_id} has #{count} instance(s)" if count > 1
    end
  end

  task :dup_page_types => :environment do
    counts = ::PageType.group(:title).count
    counts.each do |title, count|
      p "Page Type #{title} has #{count} instance(s)" if count > 1
    end
  end
end
