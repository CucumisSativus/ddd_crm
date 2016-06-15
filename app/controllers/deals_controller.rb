class DealsController < ApplicationController
  def index
    user = current_user_entity
    query = Deals::FindAllInUsersScope.new(user)
    render :index, locals: { deals: query.execute, possible_stages: possible_stages}
  end

  def show
    user = current_user_entity
    deal = Deals::FindByIdInUsersScope.new(user, params.fetch(:id)).execute
    attachments = Attachments::FindAllInAttachableScope.new('deal', deal.id).execute

    render :show, locals:  {deal: deal, attachments: attachments }
  end

  def create
    user = current_user_entity
    action = Deals::Add.new(user, params)
    action.execute
    redirect_to deals_path
  end

  def edit
    user = current_user_entity
    query = Deals::FindByIdInUsersScope.new(user, params.fetch(:id))
    render :edit, locals:  {deal: query.execute, possible_stages: possible_stages }
  end

  def update
    user = current_user_entity
    action = Deals::Update.new(user, params[:id], params)
    action.execute
    redirect_to deals_path
  end

  def destroy
    user = current_user_entity
    action = Deals::Remove.new(user, params[:id])
    action.execute
    redirect_to deals_path
  end

  def add_attachment
    action = Attachments::Add.new('deal', params[:id], params)
    action.execute
    redirect_to deal_path(params[:id])
  end
  private

  def possible_stages
    Deals::Stage::STAGES.map { |k,v| [v, k] }
  end
end