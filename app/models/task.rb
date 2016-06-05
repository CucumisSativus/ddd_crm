class Task < ApplicationRecord
  belongs_to :user

  scope :by_user, ->(user) { where(user: user) }
  scope :by_user_id, ->(user_id) { where(user_id: user_id) }
end
