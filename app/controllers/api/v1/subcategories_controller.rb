class Api::V1::SubcategoriesController < ApplicationController
	def index 
		subcategories = Subcategory.all
		render json: subcategories, status: :ok
	end

	def show 
		subcategories = Subcategory.find(params[:id])
		render json: subcategories, status: :ok
	end
end
