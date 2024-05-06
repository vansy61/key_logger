class Admin::FbProfilesController < Admin::BaseController
  def index
    params[:page] ||= 1;
    @q = FbProfile.accessible_by(current_ability).ransack(params[:q])
    @profiles = @q.result(distinct: true).order("created_at desc");
    @profiles = @profiles.page(params[:page]).per(25);
  end

  def destroy
    @profile = FbProfile.accessible_by(current_ability).find_by_id(params[:id])
    @profile.destroy if @profile.present?
    redirect_to admin_fb_profiles_path, notice: "Successfully deleted."
  end
end
