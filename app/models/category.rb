class Category < ApplicationRecord
  has_many :products
  has_ancestry

  scope :cwith_keywords, ->keywords {
          if keywords.present?
            columns = [:name]
            where(keywords.to_s.split(/[[:blank:]]+/).reject(&:empty?).map { |keyword|
              columns.map { |a| arel_table[a].matches("%#{keyword}%") }.inject(:or)
            }.inject(:or))
          end
        }

  scope :keyword, ->(search_param = nil) {
          return if search_param.blank?
          joins("INNER JOIN products ON products.category_id = categories.id")
            .where("products.category_id LIKE ? OR categories.id LIKE ? ", "%#{search_param}%", "%#{search_param}%")
        }

  private

  def self.ransackable_scopes(auth_object = nil)
    %i(keyword)
  end
end
