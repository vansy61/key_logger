class Admin::FbProfilesController < Admin::BaseController
  def index
    params[:page] ||= 1;
    @q = FbProfile.ransack(params[:q])
    @profiles = @q.result(distinct: true).order("created_at desc");
    @profiles = @profiles.page(params[:page]).per(25);
  end
end
