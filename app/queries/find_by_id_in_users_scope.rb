class FindByIdInUsersScope
  attr_reader :user_id
  attr_reader :id
  attr_reader :repository

  def initialize(user, id, repository)
    @user_id = user.id
    @id = id
    @repository = repository
  end

  def execute
    repository.find_in_user_scope(user_id, id)
  end
end
