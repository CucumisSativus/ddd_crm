class UserRepository < Repository
  def initialize(adapter = User)
    super
  end

  private
  def map_record(record)
    UserEntity.new(
                  id: record.id,
                  email: record.email,
                  is_admin: record.roles.where(role_type: Role::ADMIN_ROLE_TYPE).count != 0
    )
  end

end