module Contacts
  class FindAllInUsersScope
    attr_reader :user_id
    attr_reader :repository

    def initialize(user, repository = ContactRepository.new)
      @user_id = user.id
      @repository = repository
    end

    def execute
      repository.all_in_user_scope(user_id)
    end
  end
end