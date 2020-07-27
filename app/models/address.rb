class Address < ApplicationRecord
  belongs_to :user, optional: true

  VALID_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/

  validates :code, presence: true, format: { with: VALID_CODE_REGEX, message: "は3桁の半角数字、ハイフン（-）、4桁の半角数字の順で記入してください。" }
  validates :area, presence: true
  validates :city, presence: true
  validates :village, presence: true
end