class Post < ApplicationRecord
  belongs_to :user

  has_slug by: :title, scope: :user_id
end
