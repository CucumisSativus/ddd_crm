module Deals
  class Remove
    attr_reader :deal, :repository

    def initialize(user, contact_id, repository = DealRepository.new)
      @repository = repository
      @deal = repository.find_in_user_scope(user.id, contact_id)

    end

    def execute
      repository.destroy!(deal)
    end
  end
end