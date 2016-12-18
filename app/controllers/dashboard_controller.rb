class DashboardController < ApplicationController

  def index
    if current_user

      if current_user.allowed_to_see?(current_folder)
        @shared_folders = current_user.shared_with_me
      else
        render plain: '404 Not found', status: 404
        session[:current_folder_id] = current_user.root
      end
    end
  end
end
