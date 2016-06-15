class InMemoryAdapter
  attr_accessor :db
  class FakeRoles
    def where(*args)
      self
    end

    def count
      self
    end
  end

  def initialize
    @db = []
  end

  def all
    db
  end

  def find(id)

  end

  def create!(params = {})
    @db << OpenStruct.new(params.merge(id: @db.count, roles: FakeRoles.new))
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