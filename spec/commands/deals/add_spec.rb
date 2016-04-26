require 'rails_helper'

RSpec.describe Deals::Add, type: :model do
  let(:user) { UserRepository.new(InMemoryAdapter.new).create!({ email: "user@example.com", password: '123456789' }) }
  let(:repository) { DealRepository.new(InMemoryAdapter.new) }

  describe 'happy path' do
    let(:name) { 'name' }
    let(:summary) { 'summary' }
    let(:amount) { 10.0 }
    let(:stage_code) { Deals::Stage::QUALIFIED }
    let(:params) { {name: name, summary: summary, amount: amount, stage: stage_code} }
    let(:command) { Deals::Add.new(user, params, repository) }

    it 'creates object inside the database' do
      expect { command.execute }.to change { repository.count }.by(1)
    end

    it 'sets proper name' do
      expect(command.execute.name).to eq(name)
    end

    it 'sets proper summary' do
      expect(command.execute.summary).to eq(summary)
    end

    it 'sets proper amount' do
      expect(command.execute.amount).to eq(amount)
    end

    describe 'stage' do
      let(:stage) { command.execute.stage }

      it 'sets proper stage name' do
        expect(stage.name).to eq('Qualified')
      end

      it 'set proper stage code' do
        expect(stage.code).to eq(Deals::Stage::QUALIFIED)
      end
    end
  end

  describe 'with empty params' do
    let(:params) { {} }
    let(:command) { Deals::Add.new(user, params, repository) }

    it 'does not save itself to the database' do
      expect(command.execute).to be false
      expect(command.errors).not_to be_empty
    end
  end

  describe 'with nil amount' do
    let(:params) { { name: 'name' } }
    let(:command) { Deals::Add.new(user, params, repository) }

    it 'saves like a boss' do
      expect { command.execute }.to change { repository.count }.by(1)
    end
  end
  describe 'with negaive amount' do
    let(:params) { {name: 'name', amount: -1.0} }
    let(:command) { Deals::Add.new(user, params, repository) }

    it 'does not save itself to the database' do
      expect(command.execute).to be false
      expect(command.errors).not_to be_empty
    end
  end
end