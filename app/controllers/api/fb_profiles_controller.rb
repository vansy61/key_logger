class Api::FbProfilesController < Api::BaseController
  def check_url
    profile = FbProfile.find_by_url(params[:url])
    render json: { status: profile.present? }
  end

  def add_url
    profile = FbProfile.create(user_id: @current_user.id, url: params[:url], uuid: params[:uuid])
    render json: { status: profile.present? }
  end
end