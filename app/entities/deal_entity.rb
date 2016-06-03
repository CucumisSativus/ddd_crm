class DealEntity
  include ::Virtus.model
  include ActiveModel::Serialization

  attribute :id,  Integer
  attribute :name, String
  attribute :summary, String
  attribute :amount, Decimal
  attribute :stage, Deals::Stage
  attribute :user_id, Integer
  attribute :created_at, DateTime
  attribute :updated_at, DateTime

  def initialize(opts = {})
    @id = opts[:id]
    @stage = opts[:stage]
    @summary = opts[:summary]
    @name = opts[:name]
    @amount = opts[:amount]
    @user_id = opts[:user_id]
    @created_at = opts[:created_at]
    @updated_at = opts[:updated_at]
    @stage = Deals::Stage.new(opts[:stage]) if opts[:stage]
  end

  def stage_name
    return '' if !stage.present?
    stage.name
  end
end

