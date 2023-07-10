class EstablishmentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :details, :avatar, :cover, :address
  has_many :users
  has_many :products
  has_many :category_types

  def cover
    if object.cover.attached?
      return url_for(object.cover)
    end
  end

  def avatar
    if object.avatar.attached?
      return url_for(object.avatar)
    end
  end

  def address
    return object.address
  end

end
