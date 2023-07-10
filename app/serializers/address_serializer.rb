class AddressSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :cep, :city, :neighborhood, :street, :number, :complement, :uf, :district, :state


  def cep
    Rails.logger.info("+++++++++++++++++++++++++++++==")
    Rails.logger.info("+++++++++++++++++++++++++++++==")
    Rails.logger.info("+++++++++++++++++++++++++++++==")
    Rails.logger.info("+++++++++++++++++++++++++++++==")
    Rails.logger.info("+++++++++++++++++++++++++++++==")
    Rails.logger.info("+++++++++++++++++++++++++++++==")
    Rails.logger.info("+++++++++++++++++++++++++++++==")
    Rails.logger.info("+++++++++++++++++++++++++++++==")
  end
end
