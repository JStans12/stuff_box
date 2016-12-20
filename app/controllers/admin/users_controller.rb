class Admin::UsersController < Admin::BaseController
  before_action :admin_user,     only: :destroy

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    if user.save
      flash[:success] = "Account for #{user.username} updated!"
      redirect_to admin_dashboard_index_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.shares.destroy_all
    user.folders.destroy_all
    user.destroy!
    flash[:success] = "User deleted"
    redirect_to admin_dashboard_index_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :cellphone)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
