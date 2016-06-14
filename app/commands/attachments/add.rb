module Attachments
  class Add
    include ::Virtus.model
    include ::ActiveModel::Validations

    attr_reader :repository
    attr_reader :result

    attribute :attachable_id
    attribute :attachable_type
    attribute :document

    def initialize(attachable_type, attachable_id, params, repository = AttachmentRepository.new)
      @document = params[:attachment][:document]
      @attachable_type = attachable_type
      @attachable_id = attachable_id
      @repository = repository
    end

    def execute
      return false unless valid?
      @result = repository.create!(attributes)
    end
  end
end