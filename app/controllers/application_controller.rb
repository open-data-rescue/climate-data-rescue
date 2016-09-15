class ApplicationController < ActionController::Base
  # protect_from_forgery
  # rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_url, :alert => exception.message
  # end
  
    def ensure_login
        redirect_to "/login", alert: 'Login required' unless current_user
    end
  
  #function to restrict access of a page to admins only
  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user && current_user.admin?
  end
  
end
