require 'rails_helper'

RSpec.describe Api::V1::DealsController, type: :controller do
  include LoginHelpers
  before(:each) do
    login_user
  end

  let!(:user) { UserRepository.new.all.last }
  let!(:deal1) { DealRepository.new.create!( {user_id: user.id, stage: 1 , name: 'deal1', summary: 'summary1', amount: 10.0}) }
  let!(:deal2) { DealRepository.new.create!( {user_id: user.id, stage: 1 , name: 'deal2', summary: 'summary2', amount: 20.0}) }

  example 'user obtains his contacts' do
    get :index

    resp = JSON.parse(response.body)
    expect(resp['deals'].count).to eq(2)
    expect(resp['deals'].map{ |c| c['id'] }).to match_array([deal1.id, deal2.id])
    expect(resp['deals'].map{ |c| c['name'] }).to match_array([deal1.name, deal2.name])
    expect(resp['deals'].map{ |c| c['summary'] }).to match_array([deal1.summary, deal2.summary])
    expect(resp['deals'].map{ |c| c['amount'] }).to match_array([deal1.amount.to_s, deal2.amount.to_s])
    expect(resp['deals'].map{ |c| c['stage']['name'] }).to match_array([deal1.stage.name, deal2.stage.name])
    expect(resp['deals'].map{ |c| c['stage']['code'] }).to match_array([deal1.stage.code, deal2.stage.code])
  end
end