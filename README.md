# このアプリについて
<img width="1453" alt="Fleamarket_sample_72b" src="https://user-images.githubusercontent.com/62044473/89704084-0e7ddd80-d98c-11ea-8af2-26fad000c4af.png">
このアプリはMercariを参考にして作成したフリーマーケットサイトです。商品ユーザー登録、商品登録、商品購入、カテゴリー、検索、コメント機能がメイン機能として実装されています。  


- 開発メンバー：TECH CAMP 72期夜間メンバー4名  
- 制作期間:Jun 6th,2020 ~ Aug 15th,2020  

# 実装内容
Coming soon...

# サイトURL（BASIC認証キー）
- パブリックIP: http://54.238.15.114/
- ユーザーID: admin
- パスワード: flemakt72b

# Gem/Ver

- ruby 2.5.1
- rails 5.2.3

- gem 'mysql2', '>= 0.4.4', '< 0.6.0'
- gem 'sass-rails', '~> 5.0'
- gem 'jbuilder', '~> 2.5'
- gem 'unicorn', '5.4.1'
- gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
- gem 'capistrano'
- gem 'capistrano-rbenv'
- gem 'capistrano-bundler'
- gem 'capistrano-rails'
- gem 'capistrano3-unicorn'
- gem 'rspec-rails'
- gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
- gem "haml-rails"
- gem 'font-awesome-sass'
- gem 'devise'
- gem 'pry-rails'
- gem 'ancestry'
- gem 'gretel'
- gem 'carrierwave'
- gem 'mini_magick'
- gem 'jquery-rails'
- gem 'fog-aws'
- gem 'active_hash'
- gem 'payjp'
- gem 'rails-i18n'
- gem 'omniauth-facebook'
- gem 'omniauth-google-oauth2'
- gem 'omniauth-rails_csrf_protection'

# DB設計
## ER図
Coming soon...

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detal|text|null: false|
|size|string|null: false|
|brand|string||
|condition|string|null: false|
|postage|string|null: false|
|shipping_day|string|null: false|
|price|integer|null: false|
|likes_count|integer|default: 0|
|prefecture_id|string|null: false|
|user_id|references|null: false, foreign_key: true|
|buyer_id|integer|null: false|
|||add_index :products, :name|
|||add_index :products, :price|

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
|ancestry|string|default: null|
|||add_index :categories, :ancestry|
|||add_index :categories, :name|

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
|||add_index :users, :name|
|||add_index :users, :email, unique: true|
|||add_index :users, :reset_password_token, unique: true|


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
|village|string|null: false|
|building|string||
|phone_number|integer||
|user_id|references|null: false, foreign_key: true|
|||add_index :addresses, :area|
|||add_index :addresses, :city|

### Association
- belongs_to :user
- belongs_to :user, optional: true

- VALID_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/

- validates :code, presence: true, format: { with: VALID_CODE_REGEX, message: "は3桁の半角数字、ハイフン（-）、4桁の半角数字の順で記入してください。" }
- validates :area, presence: true
- validates :city, presence: true
- validates :village, presence: true

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|product_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :user
- validates :text, presence: true

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references||
|user_id|references||

### Association
- belongs_to :user, foreign_key: "user_id"
- belongs_to :product, foreign_key: "product_id", counter_cache: :likes_count

- validates :user_id, presence: true
- validates :product_id, presence: true
- validates_uniqueness_of :product_id, scope: :user_id

## Sns_credentialテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user, optional: true
