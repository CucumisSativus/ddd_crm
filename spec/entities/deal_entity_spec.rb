require 'rails_helper'

RSpec.describe DealEntity, type: :model do
  it 'creates proper deal stage' do
    Deals::STAGES.each do |stage_key, stage_value|
      deal = DealEntity.new(stage: stage_key)
      expect(deal.stage.name).to eq(stage_value)
    end
  end
end