class Admin::DashboardController < Admin::BaseController

  def show
    @users = User.all
  end

  def edit
    user = User.find(params[:user])
  end

  def update
    user = User.find(params[:user])
    @user.update(user_params)
    if @user.save
      flash[:success] = "Account for #{@user.username} updated!"
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:user])
    user.destroy!
    flash[:success] = "User deleted"
    redirect_to admin_dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :cellphone)
  end

end
