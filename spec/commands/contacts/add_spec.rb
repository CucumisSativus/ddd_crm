require 'rails_helper'

RSpec.describe Contacts::Add, type: :model do
  let(:user) { UserRepository.new(InMemoryAdapter.new).create!({ email: "user@example.com", password: '123456789' }) }
  let(:repository) { ContactRepository.new(InMemoryAdapter.new) }

  context 'happy path' do
    let(:name) { 'contact'}
    let(:email) { 'contact@example.com' }
    let(:phone) { '123456789' }
    let(:contact_params) { { name: name, email: email, phone: phone} }
    let(:command) { Contacts::Add.new(user, contact_params, repository) }

    it 'adds contact' do
      expect { command.execute }.to change { repository.count }.by(1)
    end

    it 'sets proper name' do
      expect(command.execute.name).to eq(name)
    end

    it 'sets proper email' do
      expect(command.execute.email).to eq(email)
    end

    it 'sets proper phone' do
      expect(command.execute.phone).to eq(phone)
    end

    context 'removing whitespace form phone' do
      let(:phone) { '1 2 3 4 5 6 7 8 9'}
      let(:contact_params) { { name: name, email: email, phone: phone} }
      let(:command) { Contacts::Add.new(user, contact_params, repository) }

      it 'sets phone without whitespace' do
        expect(command.execute.phone).to eq('123456789')
      end
    end
  end

  context 'missing required params' do
    let(:params) { {} }
    let(:command) { Contacts::Add.new(user, params, repository) }

    it 'does not create a contact' do
      expect(command.execute).to be false
      expect(command.errors).not_to be_empty
    end
  end

  context 'wrong email format' do
    let(:params) { { name: 'contact', email: 'asdsad', phone: '123456789 '} }
    let(:command) { Contacts::Add.new(user, params, repository) }

    it 'does not create a contact' do
      expect(command.execute).to be false
      expect(command.errors).not_to be_empty
    end
  end

  context 'wrong phone format' do
    let(:params) { { name: 'contact', email: 'asd@example.com', phone: 'asdcx'} }
    let(:command) { Contacts::Add.new(user, params, repository) }

    it 'does not create a contact' do
      expect(command.execute).to be false
      expect(command.errors).not_to be_empty
    end
  end
end