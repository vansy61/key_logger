class Admin::UsersController < Admin::BaseController
  def index
    params[:page] ||= 1;
    @users = User.where('1=1').order("created_at desc");
    @users = @users.page(params[:page]).per(25);
  end
end