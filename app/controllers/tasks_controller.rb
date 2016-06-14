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

  def destroy
    user = current_user
    action = Tasks::Remove.new(user, params[:id])
    action.execute
    redirect_to tasks_path
  end

  def edit
    user = current_user
    query = Tasks::FindByIdInUsersScope.new(user, params.fetch(:id))
    render :edit, locals: {task: query.execute }
  end

  def update
    user = current_user
    action = Tasks::Update.new(user, params[:id], params)
    action.execute
    redirect_to tasks_path
  end
end