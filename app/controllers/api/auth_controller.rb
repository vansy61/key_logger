class Api::AuthController < Api::BaseController
  skip_before_action :authenticate_request!, only: [:login]

  def login
    load_user

    if @user.present? && @user.valid_password?(params[:password])
      render json: payload(@user, 'Đăng nhập'), status: 200
    else
      render json: {success: false, message: 'Đăng nhập thất bại, kiểm tra lại!'}, status: :unauthorized
    end
  end

  def me
    render json: @current_user
  end


  private
  def load_user
    @user = User.find_for_database_authentication(email: params[:email])
  end

  def payload(user, mess)
    user.update(login_token: SecureRandom.hex)
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
