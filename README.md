# このアプリについて
<img width="1453" alt="Fleamarket_sample_72b" src="https://user-images.githubusercontent.com/62044473/89704084-0e7ddd80-d98c-11ea-8af2-26fad000c4af.png">
このアプリはMercariを参考にして作成したフリーマーケットサイトです。ユーザー登録・編集、商品登録・編集・購入、カテゴリー、検索、コメント、いいね機能がメイン機能として実装されています。

- 開発メンバー：TECH CAMP 72期夜間メンバー4名
- 制作期間:Jun 6th,2020 ~ Aug 15th,2020

# 実装内容
## マークアップ
TOPページ
ユーザー新規登録/ログインページ
商品出品ページ（出品ボタン）
商品詳細ページ（編集ボタン）
商品購入確認ページ
ユーザーマイページ

## サーバーサイド
### 自動デプロイ
- gem 'capistrano'
- gem 'capistrano-rbenv'
- gem 'capistrano-bundler'
- gem 'capistrano-rails'
- gem 'capistrano3-unicorn'
- gem 'fog-aws'
### ユーザー新規登録/ログイン/ログアウト（ウィザード形式での住所登録）
- gem 'devise'
### ユーザー新規登録/ログイン/パスワード不要(SNS)
- gem 'omniauth-facebook'
- gem 'omniauth-google-oauth2'
- gem 'omniauth-rails_csrf_protection'
### 商品出品・編集機能（ドラッグ&ドロップでの画像投稿）
- gem 'carrierwave'
- gem 'mini_magick'
- gem 'active_hash'
- gem 'jquery-rails'
### 商品詳細情報表示（マウスホバー＆クリックでの拡大画像表示）
- gem 'jquery-rails'
### 商品削除機能
### 商品一覧機能
- カテゴリー別、関連商品の表示
### 商品購入機能（クレジットカード登録。情報表示）
- gem 'payjp'
- gem 'rspec-rails'
### 商品についての質問・コメント機能（出品者タグ＆完売後のコメントブロック）
### カテゴリー機能
- gem 'ancestry'
- gem 'jquery-rails'
- カテゴリー一覧のページ内リンク
- マウスホバーによるカテゴリー選択機能
### キーワード検索機能
- gem 'jquery-rails'
- 複数モデルからのインクリメンタルサーチ
### 詳細検索、並べ替え機能
- gem 'ransack'
- gem 'active_hash'
- gem 'jquery-rails'
- ransackと独自メゾットの併用での検索
### パンクズ機能
- gem 'gretel'
### いいね機能
- Font Awesomeのアニメーション仕様
### マイページ機能
- Ajax通信を使った部分テンプレート
- メール/パスワード変更機能
- 住所変更機能
- プロフィール画像・紹介文登録・編集機能
### バリデーションの日本語化
- gem 'rails-i18n'



# サイトURL（BASIC認証キー）
- パブリックIP: http://54.238.15.114/
- ユーザーID: admin
- パスワード: flemakt72b

# その他、Gem/Ver

- ruby 2.5.1
- rails 5.2.3

- gem 'mysql2', '>= 0.4.4', '< 0.6.0'
- gem 'sass-rails', '~> 5.0'
- gem 'jbuilder', '~> 2.5'
- gem 'unicorn', '5.4.1'
- gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
- gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
- gem "haml-rails"
- gem 'font-awesome-sass'
- gem 'pry-rails'

# DB設計
## ER図
![ER Diagram](https://user-images.githubusercontent.com/62044473/90199620-3b107a00-de10-11ea-8be6-3ef56a5e6ee3.png)


## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detal|text|null: false|
|size|string|null: false|
|brand|string||
|condition_id|integer|null: false|
|postage_id|integer|null: false|
|shippingday_id|integer|null: false|
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
- has_one :profile
- devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]



## Addressesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_kana|string|null: false|
|last_kana|string|null: false|
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

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references||
|user_id|references||

### Association
- belongs_to :user, foreign_key: "user_id"
- belongs_to :product, foreign_key: "product_id", counter_cache: :likes_count

## Sns_credentialテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user, optional: true

## Profilesテーブル
|Column|Type|Options|
|------|----|-------|
|profile|text||
|icon|string||
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user
- mount_uploader :icon, IconUploader
