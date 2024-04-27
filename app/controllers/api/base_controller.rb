class Api::BaseController < ActionController::Base
  respond_to :json
  before_action :authenticate_request!

  protected

  def authenticate_request!
    unauthorized if !authenticate  
  end

  def authenticate
    @decoded = JsonWebToken.decode(access_token)
    @current_user = User.find @decoded.try(:[], :user_id)
    
    if (@decoded.nil? || @current_user.blocked? || @current_user.login_token != @decoded.try(:[], :login_token))
      return false
    end
    return true
  rescue JWT::VerificationError, JWT::DecodeError
    return false
  end


  def unauthorized
    render json: { success: false, messsage: 'Not authenticated' }, status: :unauthorized
  end

  private

  def access_token
    return nil if request.headers['Authorization'].blank?
    request.headers['Authorization'].split(' ').last
  end
end
