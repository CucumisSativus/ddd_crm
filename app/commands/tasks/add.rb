module Tasks
  class Add
    include ::Virtus.model
    include ::ActiveModel::Validations

    attribute :id, Integer
    attribute :name, String
    attribute :description, String
    attribute :due_date, DateTime
    attribute :user_id, Integer
    attribute :created_at, DateTime
    attribute :updated_at, DateTime

    attr_reader :repository
    attr_reader :result

    validates :name, presence: true
    validates :user_id, presence: true

    def initialize(user, params, repository = TaskRepository.new)
      @user_id = user.id
      @repository = repository

      @name = params[:name]
      @description = params[:description]
      @due_date = params[:due_date]
      @user_id = user_id
    end

    def execute
      return false unless valid?
      @result = repository.create!(attributes)
    end
  end
end