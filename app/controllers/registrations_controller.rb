class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, :only => [:create]
  prepend_before_action :check_captcha, only: [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[
        email password password_confirmation display_name bio avatar full_name
      ]
    )
  end

  private

  def check_captcha
    if !Rails.env.development? && !captcha_solved?
      self.resource = resource_class.new sign_up_params
      respond_with_navigational(resource) { render :new }
    end
  end

  def captcha_solved?
    @captcha_solved ||= verify_recaptcha
  end
end