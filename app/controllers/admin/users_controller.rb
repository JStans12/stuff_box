class Admin::UsersController < Admin::BaseController
  before_action :admin_user,     only: :destroy

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :cellphone)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
