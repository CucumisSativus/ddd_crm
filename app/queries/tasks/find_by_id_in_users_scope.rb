module Tasks
  class FindByIdInUsersScope < ::FindByIdInUsersScope
    def initialize(user, id, repository = TaskRepository.new)
      super
    end
  end
end