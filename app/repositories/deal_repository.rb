class DealRepository < Repository
  def initialize(adapter = Deal)
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
    DealEntity.new(
                  id: record.id,
                  stage: record.stage,
                  name: record.name,
                  summary: record.summary,
                  amount: record.amount,
                  user_id: record.user_id,
                  attachments: record.attachments,
                  created_at: record.created_at,
                  updated_at: record.updated_at,
    )
  end
end