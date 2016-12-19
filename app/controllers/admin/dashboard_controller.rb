class Admin::DashboardController < Admin::BaseController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :cellphone)
  end

end
