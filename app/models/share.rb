class Share < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :folder, required: false
end
