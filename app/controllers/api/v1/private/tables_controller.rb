class Api::V1::Private::TablesController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    tables = Table.where(establishment_id: params[:establishment_id])
    render json: tables, status: :ok
  end

  def create
    quantity = params[:quantity].to_i

    table = Table.where(establishment_id: params[:establishment_id]).last
    last_table = table.nil? ? 0 : table.number

    1.upto(quantity) { |i|
      number = last_table + i
      Table.create(number: number, establishment_id: params[:establishment_id], name: "Mesa #{number}")
    }

    render json: {"status": "OK", "target": "/admin/establishments/#{params[:establishment_id]}/edit#form-tables"}, status: :ok

  rescue => e
    Rails.logger.error '-----------------------------------------------'
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end
end
