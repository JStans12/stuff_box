class Admin::BaseController < ApplicationController
  before_action :require_admin
  helper_method :current_user, :current_folder, :current_admin

  add_flash_types :success, :info, :warning, :danger

  def require_admin
    render file: "public/404" unless current_admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_folder
    @current_folder ||= Folder.find(session[:current_folder_id]) if session[:current_folder_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

end
