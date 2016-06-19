module Users
  class MakeAdmin
    attr_reader :record_id, :repository
    def initialize(user_to_be_promoted_id, repository = UserRepository.new)
      @repository = repository
      @record_id = user_to_be_promoted_id
    end

    def execute
      repository.add_role_to_user(record_id, 1)
    end
  end
end