
module Api
  # Base API Controller
  class BaseController < ActionController::API
    respond_to :json
  end
end
