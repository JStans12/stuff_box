class Admin::UsersController < Admin::BaseController
  before_action :admin_user,     only: :destroy

  def show
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    if @user.save
      flash[:success] = "Account for #{@user.username} updated!"
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :cellphone)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
