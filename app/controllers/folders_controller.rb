class FoldersController < ApplicationController
  def index
    session[:current_folder_id] = params[:folder]
    redirect_to root_path
  end

  def up
    session[:current_folder_id] = current_folder.parent.id
    redirect_to root_path
  end

  def root
    session[:current_folder_id] = current_user.root
    redirect_to root_path
  end

  def new
  end

  def create
    folder = current_user.new_folder(params[:name], current_folder)
    folder.public_folder! if params[:public]
    redirect_to root_path
  end
end
