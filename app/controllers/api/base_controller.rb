
module Api
  # Base API Controller
  class BaseController < ActionController::API
    include Pundit

    respond_to :json

    rescue_from ActiveRecord::RecordNotFound, with: -> { render json: { error: 'Not found' }, status: :not_found }
    rescue_from Pundit::NotAuthorizedError, with: :reject_forbidden_request

    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    before_action :set_locale

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
  
    def self.deserializable_resource(key, options = {}, &block)
      options = options.dup
      klass = options.delete(:class) ||
              Class.new(JSONAPI::Rails::DeserializableResource, &block)

      before_action(options) do |controller|
        hash = controller.params.to_unsafe_hash.slice(:data)

        if hash.nil?
          JSONAPI::Rails.logger.warn do
            "Unable to deserialize #{key} because no JSON API payload was" \
            " found. (#{controller.controller_name}##{params[:action]})"
          end
          next
        end

        ActiveSupport::Notifications
          .instrument('parse.jsonapi-rails',
                      key: key, payload: hash, class: klass) do
          JSONAPI::Parser::Resource.parse!(hash)
          resource = klass.new(hash[:data])
          controller.request.env[JSONAPI_POINTERS_KEY] =
            resource.reverse_mapping
          controller.params[key.to_sym] = resource.to_hash
        end
      end
    end



    def reject_forbidden_request(error)
      type = error.record.name unless error.record.nil?
      human_action = params[:action].humanize(capitalize: false)
      error = {
        status: :forbidden,
        title: "#{human_action.titleize} Forbidden",
        detail: "You don't have permission to #{human_action} this #{type}.",
      }

      render jsonapi_errors: [error], status: :unauthorized
    end

    protected

    def available_filters
      raise ::NoMethodError, 'you must override this method in the subclass to provide the available filters as an array of symbols'
    end

    def query_filters
      return if params[:filters].blank?

      filters = params.require(:filters).permit(
        *available_filters
      ).to_h

      filters
    end

    def query_sort
      return if params[:sort].blank?

      params.require(:sort).permit(:key, :desc)
    end

    def query_page
      return if params[:page].blank?

      params.require(:page).permit(:number, :size)
    end

    def query_op
      return if params[:'query:op'].blank?

      params.permit(:'query:op')[:'query:op']
    end
  end
end
