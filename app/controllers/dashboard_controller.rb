class DashboardController < ApplicationController

  def index
    @shared_folders = current_user.shared_with_me if current_user
  end
end
