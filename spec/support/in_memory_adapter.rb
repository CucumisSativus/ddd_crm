class InMemoryAdapter
  attr_accessor :db

  def initialize
    @db = []
  end

  def all
    db
  end

  def create!(params = {})
    @db << OpenStruct.new(params.merge(id: @db.count))
    @db.last
  end

  def count
    @db.count
  end

  def not_found_error_class
    StandardError
  end

  def record_invalid_error_class
    StandardError
  end
end