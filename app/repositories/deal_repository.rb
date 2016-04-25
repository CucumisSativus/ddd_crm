class DealRepository < Repository
  def initialize(adapter = Deal)
    super
  end

  def all_in_user_scope(user_id)
    orm_adapter.by_user_id(user_id).map{ |r| map_record(r)}
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
                  created_at: record.created_at,
                  updated_at: record.updated_at,
    )
  end
end