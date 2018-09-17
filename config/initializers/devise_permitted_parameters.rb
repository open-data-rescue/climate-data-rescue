module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[
        email password password_confirmation display_name bio avatar
      ]
    )
  end

end

DeviseController.send :include, DevisePermittedParameters