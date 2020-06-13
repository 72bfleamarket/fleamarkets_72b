# DB設計
## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|details|text|null: false|
|category|references|null: false, foreign_key: true|
|size|string|null: false|
|brand|string||
|condition|string|null: false|
|postage|string|null: false|
|region|string|null: false|
|shipping_day|integer|null: false|
|price|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_many :images, dependent: :destroy
- belongs_to :category

- validates :name, details, category, condition, postage, region, shipping_day, price, presence: true
- validates :price :numericality: { only_integer: true,　greater_than: 0, less_than: 9999999}

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :product

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
|nick_name|string|null: false|
|email|string|null: false, unique: true|
|password|string|:encrypted_password, null: false, default: ""|
|first_name|string|null: false|
|last_name|string|null: false|
|first_kana|string|null: false|
|last_kana|string|null: false|
|number|integer|null: false|
|credit|||
|profile|text|null: false|
|icons|string|null: false|


### Association
- has_many :products,  dependent: :destroy
- has_many :addresses,  dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :cards, dependent: :destroy

## Addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
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
