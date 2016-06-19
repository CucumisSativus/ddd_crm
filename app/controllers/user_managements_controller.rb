class UserManagementsController < ApplicationController
  def show
    query = Users::FindAllWithoutCurrentUser.new(current_user_entity)
    render :show, locals: { users: query.execute }
  end

  def remove_user
    user_id = params[:user_id]
    action = Users::Remove.new(user_id)
    action.execute

    redirect_to user_management_path
  end

  def make_admin
    user_id = params[:user_id]
    action = Users::MakeAdmin.new(user_id)
    action.execute

    redirect_to user_management_path
  end
end