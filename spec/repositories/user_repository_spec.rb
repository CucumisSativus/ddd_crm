require 'rails_helper'

RSpec.describe UserRepository, type: :model do
  let(:adapter) { User }
  let(:repository) { UserRepository.new }

  describe '#all' do
    context 'when users present in the database' do
      let!(:users) do
        3.times do |n|
          adapter.create!(summary: "email#{n}@example.com", password: '12345678')
        end
      end

      before do
        expect(repository.all).not_to be_empty
      end

      it 'return UserEntity objects' do
        repository.all.each do |user_object|
          expect(user_object).to be_a(UserEntity)
        end
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

      it 'returns UserEntity' do
        expect(repository.find(user.id)).to be_a(UserEntity)
      end
    end

    context 'when user is not present' do
      it 'raises RecordNotFound' do
        expect { repository.find(1) }.to raise_error(Repository::RecordNotFound)
      end
    end
  end

  describe '#new' do
    it 'returns new UserEntity instance' do
      expect(repository.new).to be_a(UserEntity)
    end
  end

  describe '#create!' do
    context 'with proper params' do
      let(:proper_params) { { email: 'email@example.com', password: '12345678' } }

      it 'persists the model' do
        expect { repository.create!(proper_params) }.to change { User.count }.by(1)
      end
    end

    context 'with faulty params' do
      let(:faulty_params) { { email: 'asd'} }

      it 'raises RepositoryRecordInvalid' do
        expect { repository.create!(faulty_params) }.to raise_error(Repository::RecordInvalid)
      end
    end
  end

  describe '#update!' do
    let(:db_user) { User.create!(email: 'email@example.com', password: '12345678') }
    let(:repository_user) { repository.find(db_user.id) }

    context 'with proper params' do
      let(:proper_params) { { email: 'new_email@example.com' } }

      it 'persists changes' do
        pending 'need to move it to command'
        repository_user.update!(proper_params)
        expect(repository.find(db_user.id).email).to eq(proper_params.fetch('email'))
      end
    end

    context 'with faulty params' do
      let(:faulty_params) { { email: 'asd' } }

      it 'raises RepositoryRecordInvalid' do
        pending 'need to move it to command'
        expect { repository_user.update!(faulty_params) }.to raise_error(Repository::RecordInvalid)
      end
    end
  end
end
