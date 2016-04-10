class ContactRepository < Repository
  def initialize(adapter = Contact)
    super
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