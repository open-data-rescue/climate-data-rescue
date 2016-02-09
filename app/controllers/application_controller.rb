class ApplicationController < ActionController::Base
  # protect_from_forgery
  # rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_url, :alert => exception.message
  # end
  # #function to restrict access of a page to admins only
  # def authorize_admin
    # redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  # end
  
end
