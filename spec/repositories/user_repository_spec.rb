require 'rails_helper'

RSpec.describe UserRepository, type: :model do
  let(:adapter) { User }
  let(:repository) { UserRepository.new }

  describe '#all' do
    context 'when users present in the database' do
      let!(:users) do
        3.times do |n|
          adapter.create!(email: "email#{n}@example.com", password: '12345678')
        end
      end

      before do
        expect(repository.all).not_to be_empty
      end
      it 'returns same number of elements' do
        expect(repository.all.count).to eq(User.all.count)
      end

      it 'returns same ids and emails' do
        expect(repository.all.map(&:email)).to match_array(User.all.map(&:email))
        expect(repository.all.map(&:id)).to match_array(User.all.map(&:id))
      end
    end

    context 'when no user is present in the database' do
      it 'returns empty array' do
        expect(repository.all).to eq([])
      end
    end
  end

  describe '#find' do
    context 'when user with given id exists in the database' do
      let(:user) { adapter.create!(email: "email@example.com", password: "12345678") }

      it 'return user with the same id and email' do
        db_user = adapter.find(user.id)
        repository_user = repository.find(user.id)

        expect(repository_user.id).to eq(db_user.id)
        expect(repository_user.email).to eq(db_user.email)
      end

      it 'should return UserEntity' do
        expect(repository.find(user.id)).to be_a(UserEntity)
      end
    end

    context 'when user is not present' do
      it 'should raise RecordNotFound' do
        expect { repository.find(1) }.to raise_error(Repository::RecordNotFound)
      end
    end
  end
end
