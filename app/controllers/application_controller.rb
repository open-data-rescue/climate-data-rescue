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


  helper_method :page_dates_hash
  def page_dates_hash
    dates = {}

    date_array = Page.order("start_date asc").pluck("distinct start_date")

    if date_array.any?
      dates = date_array.group_by{|d| d.year}

      dates.each do |year, days|
        dates[year] = dates[year].collect{|d| d.month}.uniq
      end
    else
      dates = nil
    end
  end

  
end
