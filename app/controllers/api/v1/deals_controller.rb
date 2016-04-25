module Api::V1
  class DealsController < BaseController
    def index
      user = current_user
      query = Deals::FindAllInUsersScope.new(user)
      render json: query.execute, each_serializer: DealSerializer, root: 'deals'
    end
  end
end
