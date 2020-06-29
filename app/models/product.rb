class Product < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :category
  has_many :images, dependent: :destroy
  belongs_to :buyer, class_name: "User"

  accepts_nested_attributes_for :images, allow_destroy: true
  validates :images, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
