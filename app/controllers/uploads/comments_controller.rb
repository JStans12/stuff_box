class Uploads::CommentsController < ActionController::API
  before_action :authenticate

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: { Failure: "Your shit didn't work"}
    end
  end

  def index
    user = User.find_by(username: params[:username])
    comments = user.comments
    render json: comments
  end

  def update
    comment = Comment.update(params[:comment_id], content: params[:content])
    user = User.find_by(username: params[:username])
    if comment.user = user
      comment.save
      render json: comment
    else
      render json: { failure: "you trying to game the system bro?" }
    end
  end

  def destroy
    comment = Comment.update(params[:comment_id], content: params[:content])
    user = User.find_by(username: params[:username])
    if comment.user = user
      comment.destroy!
      render json: { success: "Your comment is gone forever!" }
    else
      render json: { failure: "you trying to game the system bro?" }
    end
  end

  private
    def comment_params
      params[:user_id] = User.find_by(username: params[:username]).id
      params.permit(:upload_id, :user_id, :content)
    end

    def authenticate
      user = User.find_by(username: params[:username])
      unless ( current_user && current_user.username == params[:username] ) || ( params[:token] == user.token )
        render json: { failure: "Bad request"}
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
