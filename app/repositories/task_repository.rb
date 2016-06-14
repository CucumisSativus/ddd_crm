class TaskRepository < Repository
  def initialize(adapter = Task)
    super
  end

  def all_in_user_scope(user_id)
    orm_adapter.by_user_id(user_id).map{ |r| map_record(r)}
  end

  def find_in_user_scope(user_id, id)
    map_record(orm_adapter.by_user_id(user_id).find(id))
  rescue orm_adapter.not_found_error_class => e
    raise Repository::RecordNotFound, e.message
  end

  private

  def map_record(record)
    TaskEntity.new(
                  id: record.id,
                  name: record.name,
                  description: record.description,
                  user_id: record.user_id,
                  due_date: record.due_date,
                  created_at: record.created_at,
                  updated_at: record.updated_at
    )
  end
end