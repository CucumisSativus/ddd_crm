module LoginHelpers
  def generate_user
    User.create!({email: 'uasd@exmaple.com', password: '12345678'})
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in generate_user
  end
end