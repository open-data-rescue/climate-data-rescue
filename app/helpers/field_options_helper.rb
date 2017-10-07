module FieldOptionsHelper
  def render_default_field_options_select2
    res = []
    FieldOption.only_defaults.each_with_index do |option, idx|
      res << {
        'id' => option.id,
        'text' => option.name,
        'is_default' => true,
        'is_field_option' => true,
        'selected' => (option.value == 'empty')
      }
    end

    raw res.to_json
  end
end