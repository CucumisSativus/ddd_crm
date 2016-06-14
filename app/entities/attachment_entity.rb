class AttachmentEntity
  include ::Virtus.model

  attribute :id, Integer
  attribute :document_url, String
  attribute :document_file_name, String

  def initialize(opts = {})
    @id = opts[:id]
    @document_file_name = opts[:document_file_name]
    @document_url = opts[:document_url]
  end
end