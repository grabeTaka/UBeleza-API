class SchedulingSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :establishment, :user, :product, :professional, :subcategory

  def establishment
    return object.establishment
  end

  def user
    return object.user
  end

  def product
    return object.product
  end

  def professional
    return object.professional
  end

  def subcategory 
    subcategory = Subcategory.find(object.product.subcategory_id)
    return subcategory
  end
end