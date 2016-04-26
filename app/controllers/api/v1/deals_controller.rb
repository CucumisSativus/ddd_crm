module Api::V1
  class DealsController < BaseController
    def index
      user = current_user
      query = Deals::FindAllInUsersScope.new(user)
      render json: query.execute, each_serializer: DealSerializer, root: 'deals'
    end

    def create
      user = current_user
      action = Deals::Add.new(user, params)
      action.execute
      if action.errors.empty?
        render json: action.result, serializer: DealSerializer
      else
        render json: action.errors, status: 422
      end
    end
  end
end
