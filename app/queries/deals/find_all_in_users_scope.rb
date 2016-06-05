module Deals
  class FindAllInUsersScope < ::FindAllInUsersScope
    def initialize(user, repository = DealRepository.new)
      super
    end
  end
end