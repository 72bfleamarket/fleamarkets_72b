class Like < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :product, foreign_key: "product_id", counter_cache: :likes_count

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates_uniqueness_of :product_id, scope: :user_id
end
