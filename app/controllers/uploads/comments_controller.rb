class Uploads::CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    user = User.find(params[:user_if])
    render json: [comment: comment, user: user]
  end

  private
    def comment_params
      params.permit(:upload_id, :user_id, :content)
    end
end
