module Deals
  class FindByIdInUsersScope < ::FindByIdInUsersScope
    def initialize(user, id, repository = DealRepository.new)
      super
    end
  end
end