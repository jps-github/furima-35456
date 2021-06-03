class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user

  with_options presence: true do
    validates :comment
    validates :user_id
    validates :item_id
  end
end
