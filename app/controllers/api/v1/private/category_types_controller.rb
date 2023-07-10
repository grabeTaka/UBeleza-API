class Api::V1::Private::CategoryTypesController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    categories = CategoryType.all
    render json: categories, status: :ok
  end

  def create
    category_params = JSON.parse(params[:category])
    category = CategoryType.new( name: category_params )
    category.icon.attach(params[:icon])
    if category.save
      render json: category, status: :ok
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def show
    category = CategoryType.find(params[:id])
    render json: category, status: :ok
  end

  def update
    category = CategoryType.find(params[:id])
    category_params = JSON.parse(params[:category])

    category.update_attributes(name: category_params)

    if params[:icon] != "null"
      category.icon.attach(params[:icon])
    end

    if category.save
      render json: category, status: :ok
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def destroy
    category = CategoryType.find(params[:id])

    if category.destroy
      render json: category, status: :ok
    end
  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def add_category
    establishment = Establishment.find(params[:establishment_id])
    categories_id = params[:category_id]

    categories_id.each do |id|
      category  = CategoryType.find(id)
      Rails.logger.info( category.to_json  )
      establishment.category_types << category
    end

    if establishment.save
      render json: establishment, status: :ok
    end
  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def undo_category
    establishment_categories = EstablishmentCategory.where(establishment_id: params[:establishment_id], category_type_id: params[:category_id])

    establishment_categories.each do |category|
      category.delete
    end
  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end
end
