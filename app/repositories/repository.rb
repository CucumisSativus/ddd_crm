class Repository
  class RecordNotFound < StandardError; end
  class RecordInvalid < StandardError; end

  def initialize(orm_adapter)
    @orm_adapter = orm_adapter
  end

  def all
    orm_adapter.all.map{ |u| map_record(u) }
  end

  def find(id)
    map_record(orm_adapter.find(id))

  rescue orm_adapter.not_found_error_class => e
    raise Repository::RecordNotFound, e.message
  end

  def new(params = {})
    map_record(orm_adapter.new(params))
  end

  def create!(params)
    orm_adapter.create!(params)
  rescue orm_adapter.record_invalid_error_class => e
    raise Repository::RecordInvalid, e.message
  end

  def update!(repository_entity, params)
    repository_entity.update!(params)
  rescue orm_adapter.record_invalid_error_class => e
    raise Repository::RecordInvalid, e.message
  end
  private

  attr_reader :orm_adapter

  def map_record(_)
    raise NotImplementedError, 'implement in subclass'
  end
end