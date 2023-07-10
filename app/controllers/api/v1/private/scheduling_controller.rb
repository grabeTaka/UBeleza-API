class Api::V1::Private::SchedulingController < ApplicationController
	before_action :doorkeeper_authorize!

=begin
  @api {post} api/v1/scheduling Create service scheduling
  @apiName CreateScheduling
  @apiGroup Scheduling

  @apiParam {Object} scheduling
  @apiParam {Number} scheduling[stablishment_id]
  @apiParam {Number} scheduling[user_id]
  @apiParam {Number} scheduling[professional_id]
  @apiParam {Number} scheduling[product_id]
  @apiParam {String} scheduling[start]

  @apiSuccess {Object} scheduling
  @apiSuccess {Number} scheduling[id]
  @apiSuccess {Number} scheduling[stablishment_id]
  @apiSuccess {Number} scheduling[user_id]
  @apiSuccess {Number} scheduling[professional_id]
  @apiSuccess {Number} scheduling[product_id]
  @apiSuccess {String} scheduling[start]
=end
	def create
    establishment = Establishment.find(params[:scheduling][:establishment_id])
    user = User.find(params[:scheduling][:user_id])
    professional = User.find(params[:scheduling][:professional_id])
    product = Product.find(params[:scheduling][:product_id])

    scheduling = Scheduling.new(start: params[:scheduling][:start])
    parse_date = Time.parse(params[:scheduling][:start]) + (product[:details]['duration'].to_i * 60)

    end_date = "#{parse_date.year}-#{parse_date.month}-#{parse_date.day} #{parse_date.hour}:#{parse_date.min}:#{parse_date.sec}"
    scheduling.end = end_date

    scheduling.user = user
    scheduling.establishment = establishment
    scheduling.product = product
    scheduling.professional = professional

    if scheduling.save
      render json: scheduling, status: :ok
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def destroy
    scheduling = Scheduling.find(params[:id])
    if scheduling.destroy
      render json: scheduling, status: :ok
    end
  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def update
    scheduling = Scheduling.find(params[:id])
    scheduling[:start] = params[:scheduling][:start]
    parse_date = Time.parse(params[:scheduling][:start]) + (scheduling.product[:details]['duration'].to_i * 60)
    end_date = "#{parse_date.year}-#{parse_date.month}-#{parse_date.day} #{parse_date.hour}:#{parse_date.min}:#{parse_date.sec}"
    scheduling.end = end_date

    if scheduling.save
      render json: scheduling, status: :ok
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end
end
