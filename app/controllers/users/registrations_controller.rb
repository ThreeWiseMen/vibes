class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.required(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation))

    if data = session['devise.oauth_data']
      @user.authentications.build(uid: data.uid, provider: data.provider)

      # @authentication = Authentication.new({user: @user})
      # @authentication.uid = data.uid
      # @authentication.provider = data.provider
      # @authentication.save

      set_flash_message(:notice, :success, kind: data.provider.capitalize)
    end

    @user.save

    if @user.persisted?
      sign_in_and_redirect :user, @user
    else
      set_flash_message(:error, :error)
      redirect_to new_user_registration_url
    end
  end
end
