module Tasks
  class FindAllInUsersScope < ::FindAllInUsersScope
    def initialize(user, repository = TaskRepository.new)
      super
    end
  end
end