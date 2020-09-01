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
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      flash[:error] = "reCAPTCHA verification failed, please try again."
      respond_with_navigational(resource) { render :new }
    end
  end
end