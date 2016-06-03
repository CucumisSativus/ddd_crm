require 'rails_helper'

RSpec.describe Contacts::FindByIdInUsersScope, type: :model do
  let!(:user) { UserRepository.new.create!({ email: "user1@example.com", password: '123456789' }) }
  let!(:user2) { UserRepository.new.create!({summary: "user2@example.com", password: '123456789' }) }
  let!(:contact) { ContactRepository.new.create!( {user_id: user.id}) }
  let(:query) { Contacts::FindByIdInUsersScope.new(user, contact.id) }

  it 'returns contact if correct id is passed' do
    expect(query.execute).to be_present
  end

  it 'returns proper contact' do
    expect(query.execute.id).to eq(contact.id)
  end

  it 'throws Repository::RecordNotFound if wrong user passed' do
    query = Contacts::FindByIdInUsersScope.new(user2, contact.id)
    expect {query.execute }.to raise_exception(Repository::RecordNotFound)
  end

  it 'throws Repository::RecordNotFound if wrong id is passed' do
    query = Contacts::FindByIdInUsersScope.new(user, 9999)
    expect {query.execute }.to raise_exception(Repository::RecordNotFound)
  end
end