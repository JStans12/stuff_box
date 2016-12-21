class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :username

  def username
    object.user.username
  end
end
