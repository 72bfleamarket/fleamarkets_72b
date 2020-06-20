class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many   :addresses , dependent: :destroy
  # accepts_nested_attributes_for :address
  # has_many :cards, dependent: :destroy
  # has_many :products, dependent: :destroy
  # has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  # has_secure_password validations: false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  VALID_KANA_REGEX = /\A[ァ-ンー－]+\z/

  validates :name, presence: { message: "ニックネームは必須です" }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "アドレスが無効です" }
  # validates :encrypted_password,  format: { with: /\A[a-zA-Z0-9]+\z/, message: "半角英数字のみが使えます" },
  #                       confirmation: true, length: { minimum: 7, message: "文字数が足りません" }, presence: true
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: "全角文字で入力して下さい" }
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: "全角文字で入力して下さい" }
  validates :first_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "全角平仮名で入力して下さい" }
  validates :last_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "全角平仮名で入力して下さい" }
  validates :birthday, presence: { message: "生年月日は必須です" }
end
