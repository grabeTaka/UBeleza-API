class ProductsCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category_type
end
