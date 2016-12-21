class Uploads::CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    Comment.create(comment_params)
    @comments = Comment.all

    respond_to do |format|
      format.js
    end
  end

  def show

  end

  private
    def comment_params
      params.permit(:upload_id, :user_id, :content)
    end
end
