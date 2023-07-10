class TableSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::UrlFor
  
  attributes :id, :name, :number, :qrcode
  
  def qrcode
    if object.qrcode.attached?
      return url_for(object.qrcode)
    end
  end
end
