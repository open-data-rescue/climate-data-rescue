class ApplicationController < ActionController::Base
  # protect_from_forgery
  # rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_url, :alert => exception.message
  # end

  before_action :set_locale

  helper_method :baseUri, :baseUri_no_lang, :baseUri_with_lang, :request_path, :url_for_locale_switcher

  def baseUri
      '/' + I18n.locale.to_s + '/'
  end

  def baseUri_no_lang
    '/'
  end

  def baseUri_with_lang lang
    if lang
      '/' + lang.to_s + '/'
    else
      baseUri_no_lang
    end
  end

  def set_locale
      def_locale = http_accept_language.compatible_language_from(I18n.available_locales)

      if session[:locale]
        def_locale = session[:locale]
      else
        def_locale = I18n.default_locale
      end
      
      I18n.locale = params[:locale].present? ? params[:locale] : def_locale

      session[:locale] = I18n.locale
  end

  def request_path
      basepath = request.fullpath 
      if basepath.include? baseUri
        basepath = basepath.slice(baseUri.length(), basepath.length())
      end
      basepath
  end

  def url_for_locale_switcher lang, static_page: nil
    url = baseUri_with_lang(lang)
    if static_page.present? && static_page.is_a?(StaticPage)
       unless lang.nil?
        url += (static_page.send('slug_' + lang.to_s) || static_page.slug)
       else
        url += static_page.slug
       end
       url.gsub!('//', '/')
    else
      url = url + request_path.sub(baseUri.chomp('/'), '')
    end

    url
  end


  # helper_method :page_dates_hash
  # def page_dates_hash
  #   dates = {}

  #   date_array = Page.order("start_date asc").pluck("distinct start_date")

  #   if date_array.any?
  #     dates = date_array.group_by{|d| d.year}

  #     dates.each do |year, days|
  #       dates[year] = dates[year].collect{|d| d.month}.uniq
  #     end
  #   else
  #     dates = nil
  #   end
  # end

  protected
  def ensure_current_user
    unless current_user
      flash[:alert] = I18n.t('login-required-error-msg')
      redirect_to new_user_session_path
    end
  end
end
