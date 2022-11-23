
class TranscriptionQuery < BaseQuery
  def tables_hash
    {
      transcriptions: ::Transcription.arel_table,
      page: ::Page.arel_table
    }
  end

  def base_collection
    collection || ::Transcription.all
  end

  def filter_class
    QueryFilters::TranscriptionFilter
  end

  protected

  def sort_by
    if sort.key.to_s.include? '.'
      col_table_name, col = sort.key.to_s.split('.')
      tables.send(col_table_name)[col]
    else
      tables.transcriptions[sort.key]
    end
  end
end
