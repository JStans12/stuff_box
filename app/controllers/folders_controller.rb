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

  def public
    folder = Folder.find(params[:folder])
    if folder.original_owner?(current_user)
      folder.public_folder!
      redirect_to root_path, success: "Folder is now public"
    else
      redirect_to root_path, danger: 'Do not have permission'
    end
  end

  def private
     folder = Folder.find(params[:folder])
    if folder.original_owner?(current_user)
      folder.private_folder!
      redirect_to root_path, success: 'Folder is now private'
    else
      pry
      redirect_to root_path, danger: 'Do not have permission'
    end
  end

  def destroy
     folder = Folder.find(params[:id])
    if folder.original_owner?(current_user)
      folder.destroy
      redirect_to root_path, success: 'Folder is deleted'
    else
      redirect_to root_path, danger: 'Do not have permission'
    end
  end
end
