class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params.required(:user).permit(:first_name, :last_name, :email, :password))

    if data = session['devise.oauth_data']
      @authentication = Authentication.new({user: @user})
      @authentication.uid = data.uid
      @authentication.provider = data.provider
      @authentication.save
    end

    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: 'Facebook')
  end
end
