require 'spec_helper'

RSpec.describe Contacts::Remove do
  let(:repository) { ContactRepository.new }
  let(:user) { UserRepository.new(InMemoryAdapter.new).create!({email: 'user@example.com', password: '123456789'}) }
  let!(:contact) { repository.create!({user_id: user.id}) }

  let(:command) { Contacts::Remove.new(user, contact.id) }
  it 'removes the contact' do
    expect{ command.execute }.to change{ repository.count }.from(1).to(0)
  end

end