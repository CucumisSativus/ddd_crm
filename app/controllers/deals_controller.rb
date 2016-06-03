class DealsController < ApplicationController
  def index
    user = current_user
    query = Deals::FindAllInUsersScope.new(user)
    render :index, locals: { deals: query.execute, possible_stages: possible_stages}
  end

  def create
    user = current_user
    action = Deals::Add.new(user, params)
    action.execute
    redirect_to deals_path
  end

  def edit
    user = current_user
    query = Deals::FindByIdInUsersScope.new(user, params.fetch(:id))
    render :edit, locals:  {deal: query.execute, possible_stages: possible_stages }
  end

  def update
    user = current_user
    action = Deals::Update.new(user, params[:id], params)
    action.execute
    redirect_to deals_path
  end

  def destroy
    user = current_user
    action = Deals::Remove.new(user, params[:id])
    action.execute
    redirect_to deals_path
  end

  private

  def possible_stages
    Deals::Stage::STAGES.map { |k,v| [v, k] }
  end
end