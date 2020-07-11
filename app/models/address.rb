class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :code, presence: true
  validates :area, presence: true
  validates :city, presence: true
  validates :village, presence: true
end