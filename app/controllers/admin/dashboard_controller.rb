class Admin::DashboardController < Admin::BaseController

  def show
    @users = User.all
  end

end
