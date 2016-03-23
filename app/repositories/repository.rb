require 'active_support/rescuable'
class Repository
  include ActiveSupport::Rescuable

  class RecordNotFound < StandardError; end

  rescue_from ActiveRecord::RecordNotFound, with: :handle_ar_record_not_found

  def initialize(orm_adapter)
    @orm_adapter = orm_adapter
  end

  def all
    orm_adapter.all
  end

  def find(id)
    map_record(orm_adapter.find(id))

  rescue orm_adapter.not_found_error_class => e
    raise Repository::RecordNotFound, e.message
  end
  private
  attr_reader :orm_adapter

  def map_record(_)
    raise NotImplementedError
  end

  def handle_ar_record_not_found(e)
    byebug
    raise Repository::RecordNotFound, e.message
  end
end