class UserFolder < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :folder, required: false

  enum permissions: [:owner, :viewer]
end
