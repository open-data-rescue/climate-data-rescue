class ApplicationController < ActionController::Base
  # protect_from_forgery
  # rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_url, :alert => exception.message
  # end

  before_action :set_locale

  helper_method :baseUri, :baseUri_no_lang, :baseUri_with_lang, :request_path

  def baseUri
      '/' + I18n.locale.to_s
  end

  def baseUri_no_lang
    '/'
  end

  def baseUri_with_lang lang
    '/' + lang.to_s
  end
  
  def ensure_login
      redirect_to "/login", alert: 'Login required' unless current_user
  end
  
  #function to restrict access of a page to admins only
  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user && current_user.admin?
  end

  def set_locale
      def_locale = http_accept_language.compatible_language_from(I18n.available_locales)

      if session[:locale]
        def_locale = session[:locale]
      else
        def_locale = I18n.default_locale
      end
      
      I18n.locale = (params[:locale] && params[:locale].size > 0)? params[:locale] : def_locale

      session[:locale] = I18n.locale
  end

  def request_path
      basepath = request.fullpath 
      if basepath.include? baseUri
        basepath = basepath.slice(baseUri.length(), basepath.length())
      end
      basepath
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
