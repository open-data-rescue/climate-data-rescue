
module TranslationHelpers
  extend ActiveSupport::Concern

  # included do
  #   define_translation_score
  # end
  

  def translation_score(percent: true, type: :number)
    num_attrs = globalize_attribute_names.count.to_f
    num_complete = 0

    globalize_attribute_names.each do |attr|
      num_complete = num_complete + 1 if self.send(attr).present?
    end

    score = 0.0 + (num_complete/num_attrs)
    score = (score * 100) if percent
    score = score.to_s + '%' if percent && type == :string

    score
  end
    
end

