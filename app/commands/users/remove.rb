module Users
  class Remove
    attr_reader :record, :repository
    def initialize(user_to_be_removed_id, repository = UserRepository.new)
      @repository = repository
      @record = repository.find(user_to_be_removed_id)
    end

    def execute
      repository.destroy!(record)
    end
  end
end