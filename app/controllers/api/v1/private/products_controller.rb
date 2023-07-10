class Api::V1::Private::ProductsController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    products = Product.all
    Rails.logger.info("=============================")
    Rails.logger.info("=============================")
    Rails.logger.info("=============================")
    Rails.logger.info("=============================") 
    render json: products, status: :ok
  end

  def by_establishment
    products = Product.where(establishment_id: params[:establishment_id])
    render json: products, status: :ok
  end

  def create
    product_params = JSON.parse(params[:product])
    subcategory_params = JSON.parse(params[:subcategory])
    establishment_id = JSON.parse(params[:establishment])
    category_ids = JSON.parse(params[:category_id])

    product = Product.new(product_params)
    category_ids.each do |id|
      category = CategoryType.find(id)
      product.category_types << category
    end

    establishment = Establishment.find(establishment_id)
    subcategory = Subcategory.find(subcategory_params['id'])

    product.subcategory = subcategory
    product.establishment = establishment

    params[:images].each do |key, image|
      Rails.logger.error '========================== image ========================='
      product.images.attach(image)
    end

    if product.save
      render json: {"status": "success"}, status: :created
    else
      render json: {"status": "error", 'message': product.errors.full_messages}, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def destroy
    product = Product.find(params[:id])

    if product.destroy
      render json: {"status": "success"}, status: :ok
    else
      render json: {"status": "error", 'message': product.errors.full_messages}, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: :ok
  end

  def update
    subcategory_params = JSON.parse(params[:subcategory])
    establishment_id = JSON.parse(params[:establishment])
    product_id = JSON.parse(params[:id])
    product = Product.find(product_id)
    
    establishment = Establishment.find(establishment_id)
    subcategory = Subcategory.find(subcategory_params['id'])

    product.establishment = establishment
    product.subcategory = subcategory

    unless params[:images].nil?
      params[:images].each do |key, image|
        Rails.logger.error '========================== image ========================='
        product.images.attach(image)
      end
    end

    product.category_types.delete_all
    JSON.parse(params[:category_id]).each do |category|
      category = CategoryType.find( category )
      product.category_types << category
    end
    product.save

    params_product = JSON.parse(params[:product])
    product_params = {
      title: params_product['title'],
      description: params_product['description'],
      price: params_product['price'],
      details: {
        validate: params_product['details']['validate']
      }
    }

    if product.update(product_params)
      render json: {"status": "success"}, status: :ok
    else
      render json: {"status": "error", 'message': product.errors.full_messages}, status: :internal_server_error
    end

    #rescue => e
    #  Rails.logger.error '====================== ERROR ======================'
    #  Rails.logger.error e.message
    #  render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  private
  def product_params
    params.require(:product).permit( :title, :description, :price, details: {} )
  end

end
