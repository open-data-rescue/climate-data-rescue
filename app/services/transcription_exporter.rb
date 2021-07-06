require 'csv'

# Exports Transcriptions
class TranscriptionExporter
  attr_accessor :page_type, :pages, :transcriptions, :annotations, :fields,
                :field_headers, :data_entries, :page_type_id

  EXPORT_FORMATS = %i[csv json].freeze

  def initialize(page_type_id:)
    self.page_type_id = page_type_id
    self.page_type = PageType.find page_type_id
    self.fields = page_type.sorted_fields.select(:id, :field_key)
    # self.pages = page_type.pages
    self.transcriptions = Transcription.where(page_id: Page.where(page_type_id: page_type_id).select(:id).pluck(:id)).most_recent_by_page_and_user.select(:id, :page_id, :user_id, :updated_at)
    self.annotations = Annotation.with_dimensions.where(transcription_id: transcriptions.map(&:id)).order_by_date.select(:id, :observation_date, :transcription_id)
    self.data_entries = page_type.data_entries.select(:id, :value, :field_id, :annotation_id)
    self.field_headers = %w[date time transcription_id page_id user_id] +
                         fields.map(&:field_key)
  end

  def export(format: :csv)
    raise "format #{format} is not supported" unless EXPORT_FORMATS.include?(format)

    send("generate_#{format}")
  end

  def filename(format: :csv)
    "DRAW_transcriptions_#{filename_page_type}_#{filename_date}.#{format}"
  end

  private

  def generate_csv
    CSV.generate(headers: true, encoding: 'UTF-8') do |csv|
      csv << field_headers

      transcriptions.each do |transcription|
        transcription_annotations = annotations.select do |a|
          a.transcription_id === transcription.id
        end

        annotation_ids = transcription_annotations.map(&:id)

        transcription_data = data_entries.select do |de|
          annotation_ids.include?(de.annotation_id)
        end

        dates = transcription_annotations.group_by { |a| a.observation_date.utc.to_date }
        
        dates.each do |date, date_annotations|
          times = date_annotations.group_by { |a| a.observation_date.utc }

          times.each do |time, time_annotations|
            time_annotation_ids = time_annotations.map(&:id)
            row = [
              date.to_s,
              time.strftime('%H:%M'),
              transcription.id,
              transcription.page_id,
              transcription.user_id
            ]

            fields.each do |field|
              data_entry = transcription_data.find do |de|
                de.field_id === field.id &&
                time_annotation_ids.include?(de.annotation_id)
              end

              value = ''
              value = data_entry.value if data_entry

              row << value
            end
            csv << row
          end
        end
      end
    end
  end

  def generate_json
    results = []

    transcriptions.each do |transcription|
      transcription_annotations = annotations.select do |a|
        a.transcription_id === transcription.id
      end

      annotation_ids = transcription_annotations.map(&:id)

      transcription_data = data_entries.select do |de|
        annotation_ids.include?(de.annotation_id)
      end

      dates = transcription_annotations.group_by { |a| a.observation_date.utc.to_date }

      dates.each do |date, date_annotations|
        times = date_annotations.group_by { |a| a.observation_date.utc }

        times.each do |time, time_annotations|
          time_annotation_ids = time_annotations.map(&:id)

          row = {
            date: date.to_s,
            time: time.strftime('%H:%M'),
            transcription_id: transcription.id,
            page_id: transcription.page_id,
            user_id: transcription.user_id
          }

          fields.each do |field|
            data_entry = transcription_data.find do |de|
              de.field_id === field.id &&
              time_annotation_ids.include?(de.annotation_id)
            end

            value = ''
            value = data_entry.value if data_entry

            row[field.field_key.to_sym] = value
          end

          results << row
        end
      end
    end

    results
  end

  def filename_page_type
    page_type.title.gsub(' ', '-').gsub(',', '')
  end

  def filename_date
    I18n.l(DateTime.current, format: :long).gsub(' ', '-').gsub(',', '')
  end
end
