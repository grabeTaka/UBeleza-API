class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::UrlFor

  attributes :id, :title, :description, :price, :details, :images
  belongs_to :establishment
  has_many :category_types
  belongs_to :subcategory

  def images
    images = []
    if object.images.attached?
      object.images.each do |image|
        url = url_for(image)
        images << {id: image['id'], url: url}
      end
    end
    return images
  end

  def avatar
    if object.avatar.attached?
      return url_for(object.avatar)
    end
  end

end
