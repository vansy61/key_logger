class Api::AuthController < Api::BaseController
  skip_before_action :authorized, only: [:login]

  def login
    load_user

    if @user.present? && @user.valid_password?(params[:password])
      render json: payload(@user, 'Đăng nhập'), status: 200
    else
      render json: {success: false, message: 'Đăng nhập thất bại !'}, status: :unauthorized
    end
  end


  private
  def load_user
    @user = User.find_for_database_authentication(email: params[:email])
  end

  def payload(user, mess)
    user.update_attributes(login_token: SecureRandom.hex)
    access_token = JsonWebToken.encode(user_id: user.id, login_token: user.login_token)
    { 
      message: mess + " thành công !", 
      success: true, 
      data: {
        access_token: access_token,
        token_type: "Bearer"
      }
    }
  end
end
