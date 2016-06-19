class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
  has_many :user_roles
  has_many :roles, through: :user_roles

  def is_admin?
    roles.where(role_type: Role::ADMIN_ROLE_TYPE).count != 0
  end
end
