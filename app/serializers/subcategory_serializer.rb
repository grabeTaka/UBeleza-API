class SubcategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :category_type
	belongs_to :category_type

	def category_type
    return object.category_type
  end


end