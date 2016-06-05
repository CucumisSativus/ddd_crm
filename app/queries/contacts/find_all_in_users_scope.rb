module Contacts
  class FindAllInUsersScope < ::FindAllInUsersScope
    def initialize(user, repository = ContactRepository.new)
      super
    end
  end
end