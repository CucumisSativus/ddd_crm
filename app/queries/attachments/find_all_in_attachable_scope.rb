module Attachments
  class FindAllInAttachableScope
    attr_reader :attachable_type
    attr_reader :attachable_id
    attr_reader :repository

    def initialize(attachable_type, attachable_id, repository = AttachmentRepository.new)
      @attachable_type = attachable_type
      @attachable_id = attachable_id
      @repository = repository
    end

    def execute
      repository.all_in_attachable_scope(attachable_type, attachable_id)
    end
  end
end