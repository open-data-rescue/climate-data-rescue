module FieldOptionsHelper
  def render_default_field_options_select2
    render_field_options_select2(
      FieldOption.only_defaults.includes(:translations)
    )
  end

  def render_field_options_select2(options = [], select_all: false, default_value: 'empty')
    res = []
    options.each do |option|
      selected = select_all || (option.value == default_value)
      res << {
        'id' => "field_#{option.id}",
        'text' => option.name,
        'is_default' => true,
        'is_field_option' => true,
        'selected' => (option.value == 'empty')
      }
    end

    raw res.to_json
  end
end
