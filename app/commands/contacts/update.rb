module Contacts
  class Update
    include ::Virtus.model
    include ::ActiveModel::Validations

    attribute :name, String
    attribute :email, String
    attribute :phone, String

    attr_reader :repository
    attr_reader :result

    validates :name, presence: true
    validates :phone, numericality: { only_integer: true }
    validates :email, format: { with: /@/, allow_blank: true}

    def initialize(user, id, params, repository = ContactRepository.new)
      @user = user
      @id = id
      @repository = repository
      @entity = repository.find(id)
      @used_keys = params.keys

      @name = params[:name]
      @name = @entity.name unless is_key_used?(:name)

      @email = params[:email]
      @email = @entity.email unless is_key_used?(:email)

      @phone = params[:phone]
      @phone = @entity.phone unless is_key_used?(:phone)
    end

    def execute
      remove_whitespace_from_phone
      return false unless valid?
      @result = repository.update!(@id, attributes)
    end

    private

    def remove_whitespace_from_phone
      return unless @phone.present?
      @phone.gsub!(/\s+/, "")
    end

    def is_key_used?(key)
      @used_keys.include?(key.to_s)
    end

  end
end
