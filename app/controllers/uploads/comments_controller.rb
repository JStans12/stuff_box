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

  private
    def comment_params
      params.permit(:upload_id, :user_id, :content)
    end

    def authenticate
      user = User.find(params[:user_id])

      unless ( current_user && current_user.id.to_s == params[:user_id] ) || ( params[:token] == user.token )
        render json: { failure: "Bad request"}
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
