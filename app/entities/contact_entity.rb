class ContactEntity
  include ::Virtus.model

  attribute :id,  Integer
  attribute :name, String
  attribute :email, String
  attribute :phone, String
  attribute :user_id, Integer
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
end