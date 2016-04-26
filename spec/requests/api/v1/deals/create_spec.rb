require 'rails_helper'

RSpec.describe Api::V1::DealsController, type: :controller do
  include LoginHelpers
  before(:each) do
    login_user
  end

  let!(:user) { UserRepository.new.all.last }
  let!(:deal_params) { {name: 'name', stage: Deals::Stage::LOST, summary: 'summary', amount: 10.0} }
  let(:repository) { DealRepository.new }

  before do
    expect(repository.count).to eq(0)
  end

  example 'user creates his contact' do

    post :create, params: deal_params
    expect(repository.count).to eq(1)
    resp = JSON.parse(response.body)
    expect(resp['deal']['name'] ).to eq(deal_params[:name])
    expect(resp['deal']['summary'] ).to eq(deal_params[:summary])
    expect(resp['deal']['amount'] ).to eq(deal_params[:amount].to_s)
    expect(resp['deal']['stage']['name']).to eq(Deals::Stage::STAGES[deal_params[:stage]])
    expect(resp['deal']['stage']['code']).to eq(deal_params[:stage])
  end
end