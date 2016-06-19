module Api
  module V1
    class BaseController < ActionController::Base
      # skip_before_action :verify_authenticity_token
      respond_to :json
      def current_user_entity
        UserRepository.new.find(current_user.id)
      end
    end
  end
end