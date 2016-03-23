class UserEntity
  include ::Virtus.model

  attribute :id,  Integer
  attribute :email, String
end