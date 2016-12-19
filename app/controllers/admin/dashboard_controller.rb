class Admin::DashboardController < Admin::BaseController

  def show
    @users = User.all
  end

  def destroy
    user = User.find(params[:user])
    user.destroy!
    flash[:success] = "User deleted"
    redirect_to admin_dashboard_path
  end

end
