class UserRepository < Repository
  def initialize(adapter = User)
    super
  end

  private
  def map_record(record)
    UserEntity.new.tap do |user|
      user.id = record.id
      user.email = record.email
    end
  end

end