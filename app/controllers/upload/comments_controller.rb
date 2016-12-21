class Upload::CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    byebug

    redirect_to upload_path(upload)
  end

  def show

  end
end
