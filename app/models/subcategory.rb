class Subcategory < ApplicationRecord
	belongs_to :category_type
	has_one :product
end
