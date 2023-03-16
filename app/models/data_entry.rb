# TODO: Audit
class DataEntry < ActiveRecord::Base
  belongs_to :page#, required: true
  belongs_to :field#, required: true
  belongs_to :user#, required: true
  belongs_to :annotation, touch: true#, required: true

  attr_accessor :edit_notes

  has_paper_trail versions: { class_name: 'Audit::DataEntryVersion' },
                  only: [:value, :user_id],
                  meta: {
                    # Use methods to get the new values
                    value: :get_new_value,
                    user_id: :get_new_user_id,
                    # These actually get populated with the old values
                    prev_value: :value,
                    prev_user_id: :user_id,
                    # Notes ...
                    notes: :get_edit_notes
                  }

  def get_new_value
    self.value
  end

  def get_new_user_id
    self.user_id
  end

  def get_edit_notes
    self.edit_notes
  end
end
