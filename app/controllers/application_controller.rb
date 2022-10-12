class ApplicationController < ActionController::Base
  # protect_from_forgery

  before_action :set_locale

  helper_method :baseUri, :baseUri_no_lang, :baseUri_with_lang, :request_path

  def default_url_options(options = {})
    opts = options
    opts = opts.merge(host: ENV["BASE_URL"]) if ENV["BASE_URL"]
    if Rails.env.development?
      opts
    else
      opts[:port] = nil
      opts['port'] = nil
      opts.merge(protocol: 'https')
    end
  end

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
      basepath = basepath.slice(baseUri.length, basepath.length)
    end
    basepath
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
    return if current_user

    flash[:alert] = I18n.t('login-required-error-msg')
    redirect_to new_user_session_path
  end
end
