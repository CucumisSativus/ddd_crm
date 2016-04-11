class ContactRepository < Repository
  def initialize(adapter = Contact)
    super
  end

  def find_in_user_scope(user_id, id)
    orm_adapter.by_user_id(user_id).find(id)
  rescue orm_adapter.not_found_error_class => e
    raise Repository::RecordNotFound, e.message
  end

  def all_in_user_scope(user_id)
    orm_adapter.by_user_id(user_id)
  end

  private

  def map_record(record)
    ContactEntity.new.tap do |contact|
      contact.id = record.id
      contact.email = record.email
      contact.name = record.name
      contact.phone = record.phone
      contact.user_id = record.user_id
    end
  end
end