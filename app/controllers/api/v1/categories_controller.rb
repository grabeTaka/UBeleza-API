class Api::V1::CategoriesController < ApplicationController

  def index
    categories = CategoryType.all
    render json: categories, status: :ok
  end

  
  def show
    category = CategoryType.find(params[:id])
    render json: category, status: :ok
  end
  
end
