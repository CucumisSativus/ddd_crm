module Api
  module V1
    class BaseController < ActionController::Base
      # skip_before_action :verify_authenticity_token
      respond_to :json
    end
  end
end