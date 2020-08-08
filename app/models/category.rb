class Category < ApplicationRecord
  has_many :products
  has_ancestry

  scope :with_keywords, ->keywords {
          if keywords.present?
            columns = [:name]
            where(keywords.to_s.split(/[[:blank:]]+/).reject(&:empty?).map { |keyword|
              columns.map { |a| arel_table[a].matches("%#{keyword}%") }.inject(:or)
            }.inject(:or))
          end
        }
end
