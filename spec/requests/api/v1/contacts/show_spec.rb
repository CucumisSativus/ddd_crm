require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  include LoginHelpers
  before(:each) do
    login_user
  end

  let!(:user) { UserRepository.new.all.last }
  let!(:contact) { ContactRepository.new.create!( {user_id: user.id, name: 'contact1', phone: 'contact1', email: 'contact1'}) }


  example 'user obtains his contact' do
    get :show, id: contact.id

    resp = JSON.parse(response.body)
    expect(resp['contact']['id'] ).to eq(contact.id)
    expect(resp['contact']['name'] ).to eq(contact.name)
    expect(resp['contact']['phone'] ).to eq(contact.phone)
    expect(resp['contact']['email'] ).to eq(contact.email)
  end
end