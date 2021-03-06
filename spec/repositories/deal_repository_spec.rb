require 'rails_helper'

RSpec.describe DealRepository, type: :model do
  let(:adapter) { Deal }
  let(:repository) { DealRepository.new }

  describe '#all' do
    context 'when contacts present in the database' do
      let!(:users) do
        3.times do |n|
          adapter.create!
        end
      end

      before do
        expect(repository.all).not_to be_empty
      end

      it 'return ContactEntity objects' do
        repository.all.each do |user_object|
          expect(user_object).to be_a(DealEntity)
        end
      end

      it 'returns same number of elements' do
        expect(repository.all.count).to eq(Deal.all.count)
      end

      it 'returns same ids' do
        expect(repository.all.map(&:id)).to match_array(Deal.all.map(&:id))
      end
    end

    context 'when no deal is present in the database' do
      it 'returns empty array' do
        expect(repository.all).to eq([])
      end
    end
  end

  describe '#find' do
    context 'when contact with given id exists in the database' do
      let(:contact) { adapter.create! }

      it 'return user with the same id and email' do
        db_contact = adapter.find(contact.id)
        repository_user = repository.find(contact.id)

        expect(repository_user.id).to eq(db_contact.id)
      end

      it 'returns ContactEntity' do
        expect(repository.find(contact.id)).to be_a(DealEntity)
      end
    end

    context 'when contact is not present' do
      it 'raises RecordNotFound' do
        expect { repository.find(1) }.to raise_error(Repository::RecordNotFound)
      end
    end
  end

  describe '#new' do
    it 'returns new UserEntity instance' do
      expect(repository.new).to be_a(DealEntity)
    end
  end

  describe '#create!' do
    context 'with proper params' do
      let(:proper_params) { { } }

      it 'persists the model' do
        expect { repository.create!(proper_params) }.to change { Deal.count }.by(1)
      end
    end
  end
end
