module Tasks
  class Update
    include ::Virtus.model
    include ::ActiveModel::Validations

    attribute :id, Integer
    attribute :name, String
    attribute :description, String
    attribute :due_date, DateTime
    attribute :user_id, Integer

    attr_reader :repository
    attr_reader :result

    validates :name, presence: true
    validates :user_id, presence: true

    def initialize(user, id, params, repository = TaskRepository.new)
      @user_id = user.id
      @id = id
      @repository = repository
      @entity = repository.find_in_user_scope(user_id, id)
      @used_keys = params.keys


      @name = params[:name]
      @description = params[:description]
      @due_date = params[:due_date]
    end

    def execute
      return false unless valid?
      @result = repository.update!(@id, attributes)
    end
  end
end