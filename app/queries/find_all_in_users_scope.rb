class FindAllInUsersScope
  attr_reader :user_id
  attr_reader :repository
  attr_reader :is_user_admin

  def initialize(user, repository)
    @user_id = user.id
    @repository = repository
    @is_user_admin = user.is_admin?
  end

  def execute
    if is_user_admin
      repository.all
    else
      repository.all_in_user_scope(user_id)
    end
  end
end