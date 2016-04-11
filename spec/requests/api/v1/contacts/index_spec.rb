require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  include LoginHelpers
  before(:each) do
    login_user
  end

  let!(:user) { UserRepository.new.all.last }
  let!(:contact1) { ContactRepository.new.create!( {user_id: user.id, name: 'contact1', phone: 'contact1', email: 'contact1'}) }
  let!(:contact2) { ContactRepository.new.create!( {user_id: user.id, name: 'contact2', phone: 'contact2', email: 'contact2'}) }

  example 'user obtains his contacts' do
    get :index

    resp = JSON.parse(response.body)
    expect(resp['contacts'].count).to eq(2)
    expect(resp['contacts'].map{ |c| c['id'] }).to match_array([contact1.id, contact2.id])
    expect(resp['contacts'].map{ |c| c['name'] }).to match_array([contact1.name, contact2.name])
    expect(resp['contacts'].map{ |c| c['phone'] }).to match_array([contact1.phone, contact2.phone])
    expect(resp['contacts'].map{ |c| c['email'] }).to match_array([contact1.email, contact2.email])
  end
end