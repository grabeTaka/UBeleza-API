class CategoryType < ApplicationRecord
  has_one_attached :icon

  has_many :establishment_categories
  has_many :establishments, through: :establishment_categories

  has_many :product_categories
  has_many :products, through: :product_categories

  has_many :subcategories
end
