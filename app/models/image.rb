class Image < ApplicationRecord
  mount_uploader :item, ImageUploader
  belongs_to :product
  validates :item, presence: true
end
