require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  include LoginHelpers
  before(:each) do
    login_user
  end

  let!(:user) { UserRepository.new.all.last }
  let!(:contact_params) { {name: 'contact1', phone: '123456789', email: 'contact1@example.com'} }
  let(:repository) { ContactRepository.new }

  before do
    expect(repository.count).to eq(0)
  end

  example 'user creates his contact' do

    post :create, params: contact_params
    expect(repository.count).to eq(1)
    resp = JSON.parse(response.body)
    expect(resp['contact']['name'] ).to eq(contact_params[:name])
    expect(resp['contact']['phone'] ).to eq(contact_params[:phone])
    expect(resp['contact']['email'] ).to eq(contact_params[:email])
  end
end