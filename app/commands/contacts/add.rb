module Contacts
  class Add
    include ::Virtus.model
    include ::ActiveModel::Validations

    attribute :name, String
    attribute :email, String
    attribute :phone, String
    attribute :user_id, Integer

    attr_reader :repository
    attr_reader :result

    validates :name, presence: true
    validates :user_id, presence: true
    validates :phone, numericality: { only_integer: true }
    validates :email, format: { with: /@/, allow_blank: true}

    def initialize(user, params, repository = ContactRepository.new)
      @user = user
      @repository = repository

      @name = params[:name]
      @email = params[:email]
      @phone = params[:phone]
      @user_id = user.id
    end

    def execute
      remove_whitespace_from_phone
      return false unless valid?
      @result = repository.create!(attributes)
    end

    private

    def remove_whitespace_from_phone
      return unless @phone.present?
      @phone.gsub!(/\s+/, "")
    end
  end
end
