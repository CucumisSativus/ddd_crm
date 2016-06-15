module Users
  class FindAllWithoutCurrentUser
    attr_reader :repository, :current_user

    def initialize(current_user, repository = UserRepository.new)
      @current_user = current_user
      @repository = repository
    end

    def execute
      repository.all_except_id(current_user.id)
    end
  end
end