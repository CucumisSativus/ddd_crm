module Deals
  class Add
    include ::Virtus.model
    include ::ActiveModel::Validations


    attribute :name, String
    attribute :summary, String
    attribute :amount, Decimal
    attribute :stage, Integer
    attribute :user_id, Integer

    validates :name, presence: true
    validates :amount, numericality: { greater_than_or_equal_to: 0 , allow_nil: true}

    attr_reader :repository
    attr_reader :result

    def initialize(user, params, repository = DealRepository.new)
      @user = user
      @repository = repository

      @name = params[:name]
      @summary = params[:summary]
      @amount = params[:amount]
      @stage = params[:stage]
      @user_id = @user.id
    end

    def execute
      return false unless valid?
      @result = repository.create!(attributes)
    end
  end
end