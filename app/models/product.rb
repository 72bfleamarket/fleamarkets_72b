class Product < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :category
  has_many :images, dependent: :destroy
  belongs_to :buyer, class_name: "User"
  has_many :likes
  has_many :like_users, through: :likes, source: :user
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shippingday

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  scope :with_keywords, -> keywords {
    if keywords.present?
      columns = [:name, :brand]
      where(keywords.to_s.split(/[[:blank:]]+/).reject(&:empty?).map {|keyword|
        columns.map { |a| arel_table[a].matches("%#{keyword}%") }.inject(:or)
      }.inject(:or))
    end
  }

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true,reject_if: proc { |attributes| attributes['item'].blank?}
  validates :images, presence: { message: "は1枚以上10枚以下のアップロードが必要です" }
  validates :name, presence: { message: "は必須です" }
  validates :detal, presence: { message: "は必須です" }
  validates :category_id, presence: { message: "を選択してください" }
  validates :condition_id, presence: { message: "を選択してください" }
  validates :postage_id, presence: { message: "を選択してください" }
  validates :prefecture_id, presence: { message: "を選択してください" }
  validates :shippingday_id, presence: { message: "を選択してください" }
  validates :price, presence: { message: "を入力してください" }

  def self.search(search)
    return Product.all unless search
    Product.where('name LIKE(?)', "%#{search}%")
  end

  def previous
    Product.where('id < ?', self.id).order('id DESC').first
    end

    def next
    Product.where('id > ?', self.id).order('id ASC').first
    end
end
