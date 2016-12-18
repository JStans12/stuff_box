module SessionsHelper

  def user_action
    @user = User.find_by(email: params[:email])
    if @user.nil?
      invalid_email_action
    elsif @user && @user.authenticate(params[:password]) == false
      invalid_password_action
    elsif @user.authenticate(params[:password]) && @user.admin?
      admin_login_action
    elsif @user.authenticate(params[:password])
      user_login_action
    else
      render :new
    end
  end

  def invalid_email_action
    flash[:danger] = "Please enter a valid email!"
    render :new
  end

  def invalid_password_action
    flash[:danger] = "Password invalid!"
    render :new
  end

  def admin_login_action
    session[:user_id] = @user.id
    flash[:success] = "Logged in as #{@user.username}"
    redirect_to admin_dashboard_path
  end

  def user_login_action
    session[:user_id] = @user.id
    flash[:success] = "Logged in as #{@user.email}"
    redirect_to beers_path
  end

end
