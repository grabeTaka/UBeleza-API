class Api::V1::SchedulingController < ApplicationController

  def by_establishment
    if current_user.role == "establishment_admin"
      schedulings = Scheduling.where(establishment_id: params[:establishment_id])
    elsif current_user.role == "establishment_user"
      schedulings = Scheduling.where(professional_id: current_user.id)
    end

    render json: schedulings, status: :ok
  end

=begin
  @api {get} api/v1/scheduling/:product_id/:day Get Day's Scheduling
  @apiName GetDaysScheduling
  @apiGroup Scheduling

  @apiParam {Number} product_id
  @apiParam {String} day

  @apiSuccess {Object} [scheduling]
  @apiSuccess {Number} [scheduling[id]]
  @apiSuccess {Number} [scheduling[stablishment_id]]
  @apiSuccess {Number} [scheduling[user_id]]
  @apiSuccess {Number} [scheduling[professional_id]]
  @apiSuccess {Number} [scheduling[product_id]]
  @apiSuccess {String} [scheduling[start]]
=end
  def by_service_and_date
  end
end
