module Deals
  class Update
    include ::Virtus.model
    include ::ActiveModel::Validations

    attr_reader :repository
    attr_reader :result

    attribute :name, String
    attribute :summary, String
    attribute :amount, Decimal
    attribute :stage, Integer
    attribute :user_id, Integer
    attribute :stage, Integer

    validates :name, presence: true
    validates :amount, numericality: { greater_than_or_equal_to: 0 , allow_nil: true}

    def initialize(user, id, params, repository = DealRepository.new)
      @user_id = user.id
      @id = id
      @repository = repository
      @entity = repository.find_in_user_scope(user_id, id)
      @used_keys = params.keys

      @name = params[:name]
      @name = @entity.name unless is_key_used?(:name)

      @summary = params[:summary]
      @summary = @entity.summary unless is_key_used?(:summary)

      @amount = params[:amount]
      @amount= @entity.amount unless is_key_used?(:amount)

      @stage = params[:stage]
      @stage = @entity.stage unless is_key_used?(:stage)
    end

    def execute
      return false unless valid?
      @result = repository.update!(@id, attributes)
    end

    private

    def is_key_used?(key)
      @used_keys.map(&:to_s).include?(key.to_s)
    end
  end
end
