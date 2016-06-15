module ApplicationHelper
  def current_user_entity
    UserRepository.new.find(current_user.id)
  end
end
