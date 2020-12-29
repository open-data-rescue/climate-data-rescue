
module Api
  # Base API Controller
  class BaseController < ActionController::API
    respond_to :json

    def index
      @pages = Page.all

      render json: @pages.to_json, status: :ok
    end
  end
end
