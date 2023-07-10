class CategoryTypeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name
  has_one :icon

  def icon
    if object.icon.attached?
      return url_for(object.icon)
    end
  end
end
