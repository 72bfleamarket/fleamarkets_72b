class Address < ApplicationRecord
  belongs_to :user, optional: true

  VALID_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  VALID_KANA_REGEX = /\A[ァ-ンー－]+\z/
  VALID_PHONE_REGEX = /\A\d{10,11}\z/


  validates :code, presence: true, format: { with: VALID_CODE_REGEX, message: "は3桁の半角数字、ハイフン（-）、4桁の半角数字の順で記入してください。" }
  validates :area, presence: true
  validates :city, presence: true
  validates :village, presence: true
  validates :destination_first, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角文字で入力して下さい。" }
  validates :destination_last, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角文字で入力して下さい。" }
  validates :destination_first_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角文字で入力して下さい。" }
  validates :destination_last_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角文字で入力して下さい。" }
  validates :area_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角片仮名で入力して下さい。" }
  validates :city_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角片仮名で入力して下さい。" }
  validates :village_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角片仮名で入力して下さい。" }
  validates :building_kana, allow_blank: true, format: { with: VALID_KANA_REGEX, message: "は全角片仮名で入力して下さい。" }
  validates :phone_number, allow_blank: true, format: { with: VALID_PHONE_REGEX, message: "は10桁もしくは11桁のハイフンなし半角数字で入力して下さい。" }
end