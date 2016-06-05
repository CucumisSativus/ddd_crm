class TasksController < ApplicationController
  def index
    user = current_user
    query = Tasks::FindAllInUsersScope.new(user)
    render :index, locals: { tasks: query.execute }
  end

  def create
    user = current_user
    action = Tasks::Add.new(user, params)
    action.execute
    redirect_to tasks_path
  end
end