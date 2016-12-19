class Share < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :folder, required: false

  validates_uniqueness_of :user_id, scope: :folder_id
end
