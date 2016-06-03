require 'rails_helper'

RSpec.describe Contacts::Update, type: :model do
  let(:user) { UserRepository.new(InMemoryAdapter.new).create!({summary: "user@example.com", password: '123456789' }) }
  let(:repository) { ContactRepository.new }
  let!(:record) { repository.create!(name: 'name', email: 'sda@xcz.pl', phone: '123', user_id: user.id)}
  let(:id) { record.id }

  context 'happy path' do
    let(:name) { 'contact'}
    let(:email) { 'contact@example.com' }
    let(:phone) { '123456789' }
    let(:contact_params) { { name: name, email: email, phone: phone} }
    let(:command) { Contacts::Update.new(user, id, contact_params, repository) }

    it 'does not add any new contacts' do
      expect { command.execute }.not_to change { repository.count }
    end

    it 'sets proper name' do
      command.execute
      expect(repository.find(id).name).to eq(name)
    end

    it 'sets proper email' do
      command.execute
      expect(repository.find(id).email).to eq(email)
    end

    it 'sets proper phone' do
      command.execute
      expect(repository.find(id).phone).to eq(phone)
    end

    it 'does not change user_id' do
      command.execute
      expect(repository.find(id).user_id).to eq(record.user_id)
    end

    context 'removing whitespace form phone' do
      let(:phone) { '1 2 3 4 5 6 7 8 9'}
      let(:contact_params) { { phone: phone} }
      let(:command) { Contacts::Update.new(user, id, contact_params, repository) }

      it 'sets phone without whitespace' do
        command.execute
        expect(repository.find(id).phone).to eq('123456789')
      end
    end
  end

  context 'empty params' do
    let(:params) { {} }
    let(:command) { Contacts::Update.new(user, id, params, repository) }

    it 'does not update the contact but succeeds' do
      expect(command.execute).to be true
      expect(repository.find(id).attributes).to eq(record.attributes)
    end
  end

  context 'wrong email format' do
    let(:params) { { email: 'asdsad' } }
    let(:command) { Contacts::Update.new(user, id, params, repository) }

    it 'does not update the contact' do
      expect(command.execute).to be false
      expect(command.errors).not_to be_empty
    end
  end

  context 'wrong phone format' do
    let(:params) { { phone: 'asdcx' } }
    let(:command) { Contacts::Update.new(user, id, params, repository)  }

    it 'does not update the contact' do
      expect(command.execute).to be false
      expect(command.errors).not_to be_empty
    end
  end
end