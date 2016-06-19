class UserRepository < Repository
  def initialize(adapter = User)
    super
  end

  def all_except_id(except_id)
    orm_adapter.where.not(id: except_id).map{ |u| map_record(u) }
  end

  def add_role_to_user(record_id, role_type)
    orm_adapter.find(record_id).roles.create(role_type: role_type)
  rescue orm_adapter.not_found_error_class => e
    raise Repository::RecordNotFound, e.message
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