class UserEntity
  include ::Virtus.model

  attribute :id,  Integer
  attribute :email, String
  attribute :is_admin, Boolean

  def initialize(params ={})
    @id = params[:id]
    @email = params[:email]
    @is_admin = params[:is_admin]
  end
end