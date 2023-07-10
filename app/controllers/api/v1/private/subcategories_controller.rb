class Api::V1::Private::SubcategoriesController < ApplicationController
	before_action :doorkeeper_authorize!


	def create 
		sub_category = Subcategory.new( sub_category_params )
		category_params = JSON.parse( params[:category_type] )

		category = CategoryType.find( category_params['id'])
		sub_category.category_type = category

		if sub_category.save
			render json: sub_category, status: :ok 
		end

	rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
	end

	def destroy 
		subcategory = Subcategory.find(params[:id])

    if subcategory.destroy
      render json: subcategory, status: :ok
    end
  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
	end

	def update 
		category_params = JSON.parse( params[:category_type] )
		sub_category = Subcategory.find( params[:id] )
		category = CategoryType.find( category_params['id'] )
		sub_category.category_type = category

		if sub_category.update_attributes(name: sub_category_params['name'])
			render json: sub_category, status: :ok 
		end
	#rescue => e
  #  Rails.logger.error '====================== ERROR ======================'
  #  Rails.logger.error e.message
	#	render json: {"status": "error", "message": e.message}, status: :internal_server_error
		
	end

	private 
	def sub_category_params
		JSON.parse(params[:subCategory])
	end
end
