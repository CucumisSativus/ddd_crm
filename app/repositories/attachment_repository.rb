class AttachmentRepository < Repository
  def initialize(adapter = Attachment)
    super
  end

  def all_in_attachable_scope(attachable_type, attachable_id)
    orm_adapter.where(attachable_type: attachable_type)
        .where(attachable_id: attachable_id).map { |r| map_record(r) }
  end

  def find_in_attachable_scope(attachable_type, attachable_id, id)
    map_record(orm_adapter.where(attachable_type: attachable_type).where(attachable_id: attachable_id).find(id))
  rescue orm_adapter.not_found_error_class => e
    raise Repository::RecordNotFound, e.message
  end

  private

  def map_record(record)
    AttachmentEntity.new(
                        id: record.id,
                        document_file_name: record.document_file_name,
                        document_url: record.document.url
    )
  end
end