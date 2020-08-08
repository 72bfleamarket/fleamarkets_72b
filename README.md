# DB設計
## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detal|text|null: false|
|size|string|null: false|
|brand|string||
|condition|string|null: false|
|postage|string|null: false|
|prefecture_id|string|null: false|
|shipping_day|string|null: false|
|price|integer|null: false|
|user_id|references|null: false, foreign_key: true|
|buyer_id|integer|null: false|
|likes_count|integer|default: 0|

### Association
- belongs_to :user, foreign_key: "user_id"
- belongs_to :category
- has_many :images, dependent: :destroy
- belongs_to :buyer, class_name: "User"
- has_many :likes
- has_many :like_users, through: :likes, source: :user
- has_many :comments

- accepts_nested_attributes_for :images, allow_destroy: true,reject_if: proc { |attributes| attributes['item'].blank?}
- validates :images, presence: { message: "は1枚以上10枚以下のアップロードが必要です" }

- extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to_active_hash :prefecture

- validates :name, presence: { message: "は必須です" }
- validates :detal, presence: { message: "は必須です" }
- validates :category_id, presence: { message: "を選択してください" }
- validates :condition, presence: { message: "を選択してください" }
- validates :postage, presence: { message: "を選択してください" }
- validates :prefecture_id, presence: { message: "を選択してください" }
- validates :shipping_day, presence: { message: "を選択してください" }
- validates :price, presence: { message: "を入力してください" }

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|references|null: false, foreign_key: true|

### Association
- mount_uploader :item, ImageUploader
- belongs_to :product
- validates :item, presence: true

## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|||add_column :categories, :ancestry, :string|
|||add_index :categories, :ancestry|

### Association
- has_many: products
- has_ancestry

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false, default: ""|
|first_name|string|null: false|
|last_name|string|null: false|
|first_kana|string|null: false|
|last_kana|string|null: false|
|birthday|date|null: false|
|profile|text||
|icons|string||


### Association
- has_one :address, dependent: :destroy
- has_many :addresses , dependent: :destroy
- has_many :buyed_products, foreign_key: "buyer_id", class_name: "Product"
- has_many :saling_products, -> { where("buyer_id is NULL") }, foreign_key: "user_id", class_name: "Product"
- has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "user_id", class_name: "Product"
- has_many :products, dependent: :destroy
- has_many :sns_credentials
- has_many :likes, dependent: :destroy
- has_many :like_products, through: :likes, source: :product
- has_many :comments
- devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

- VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
- VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
- VALID_KANA_REGEX = /\A[ァ-ンー－]+\z/

- validates :name, presence: true
- validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
- validates :password, presence: true
- validates :password_confirmation, presence: true
- validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角文字で入力して下さい。" }
- validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角文字で入力して下さい。" }
- validates :first_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角平仮名で入力して下さい。" }
- validates :last_kana, presence: true, format: { with: VALID_KANA_REGEX, message: "は全角平仮名で入力して下さい。" }
- validates :birthday, presence: true


## Addressesテーブル
|Column|Type|Options|
|------|----|-------|
|code|integer|null: false|
|area|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|product_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :user

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user
