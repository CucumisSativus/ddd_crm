class DealRepository < Repository
  def initialize(adapter = Deal)
    super
  end

  private

  def map_record(record)
    DealEntity.new(
                  id: record.id,
                  stage: record.stage,
                  summary: record.summary,
                  amount: record.amount,
                  user_id: record.user_id,
                  created_at: record.created_at,
                  updated_at: record.updated_at,
                  stage: record.stage
    )
  end
end