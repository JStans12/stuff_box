class Upload::CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    content = params[:comment][:content]
    upload = current_user.uploads.find(params[:comment][:upload_id])
    comment = current_user.comments.create(content: content, upload_id: upload.id)

    redirect_to upload_path(upload)
  end

  def show

  end
end
