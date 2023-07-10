class Product < ApplicationRecord
  has_many_attached :images
  has_many :schedulings

  belongs_to :establishment

  has_many :product_categories
  has_many :category_types, through: :product_categories

  belongs_to :subcategory
end
