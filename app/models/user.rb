class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :addresses , dependent: :destroy
  # accepts_nested_attributes_for :address //後から使用予定
  # has_many :cards, dependent: :destroy //後から使用予定
  has_many :buyed_products, foreign_key: "buyer_id", class_name: "Product"
  has_many :saling_products, -> { where("buyer_id is NULL") }, foreign_key: "user_id", class_name: "Product"
  has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "user_id", class_name: "Product"
  has_many :products, dependent: :destroy
  has_many :sns_credentials
  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product
  has_many :comments
  has_one :profile
  # has_many :comments //後から使用予定
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  # has_secure_password validations: false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  VALID_KANA_REGEX = /\A[ァ-ンー－]+\z/

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角文字で入力して下さい。" }
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角文字で入力して下さい。" }
  validates :first_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角平仮名で入力して下さい。" }
  validates :last_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角平仮名で入力して下さい。" }
  validates :birthday, presence: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      name: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end