class Api::V1::EstablishmentsController < ApplicationController

  def index
    establishments = Establishment.all
    render json: establishments, status: :ok
  end

  def random
    establishments = Establishment.order("RANDOM()").limit(5)
    render json: establishments, status: :ok    
  end

  def show
    establishment = Establishment.find(params[:id])
    render json: establishment, status: :ok
  end

  def by_categories 
    categories = CategoryType.find(params[:category_id])
    products_by_category = categories.products.group_by(&:establishment_id)
    establishments = []

    products_by_category.each{ |key,value|
      establishment = Establishment.find( key )
      establishments << establishment
    }

    render json: establishments, status: :ok
  end
end
