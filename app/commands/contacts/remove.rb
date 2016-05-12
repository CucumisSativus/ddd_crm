module Contacts
  class Remove
    attr_reader :contact, :repository

    def initialize(user, contact_id, repository = ContactRepository.new)
      @repository = repository
      @contact = repository.find_in_user_scope(user.id, contact_id)

    end

    def execute
      repository.destroy!(contact)
    end
  end
end