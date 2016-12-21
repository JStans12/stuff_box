class Uploads::CommentsController < ApplicationController

  def create
    Comment.create(comment_params)
    @comments = Upload.find(params[:upload_id]).comments

    respond_to do |format|
      format.js
    end
  end

  private
    def comment_params
      params.permit(:upload_id, :user_id, :content)
    end
end
