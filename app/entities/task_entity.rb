class TaskEntity
  include ::Virtus.model
  include ActiveModel::Serialization

  attribute :id, Integer
  attribute :name, String
  attribute :description, String
  attribute :due_date, DateTime
  attribute :user_id, Integer
  attribute :created_at, DateTime
  attribute :updated_at, DateTime

  def initialize(opts = {})
    @id = opts[:id]
    @name = opts[:name]
    @description = opts[:description]
    @due_date = opts[:due_date]
    @user_id = opts[:user_id]
    @created_at = opts[:created_at]
    @updated_at = opts[:updated_at]
  end
end