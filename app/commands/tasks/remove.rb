module Tasks
  class Remove
    attr_reader :record, :repository
    def initialize(user, task_id, repository = TaskRepository.new)
      @repository = repository
      @record = repository.find_in_user_scope(user.id, task_id)
    end

    def execute
      repository.destroy!(record)
    end
  end
end