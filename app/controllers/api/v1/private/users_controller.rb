class Api::V1::Private::UsersController < ApplicationController
  before_action :doorkeeper_authorize!

  def current
    render json: current_user, status: :ok
  end

  def create
    case current_user.role
    when 'system_admin'

    end

    user = User.create!(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      name: params[:name],
      role: params[:role]
    )

    unless ( params[:role].eql? 'establishment_user' )
      establishment = Establishment.find(params[:establishment])
      user.establishments << establishment
    end

    if user.save
      render json: user.as_json(:email=>user.email), status: 201
      return
    else
      warden.custom_failure!
      render json: user.errors, status: 422
    end

  rescue => e
    Rails.logger.error '============================================================'
    Rails.logger.error e.message
    Rails.logger.error e.backtrace
  end


  def index
    users = User.all
    render json: users, status: :ok
  end


  def get_user_by_role
    users = User.where(role: 2)
    render json: users, stats: :ok
  end

  def by_role
    users = User.where(role: params[:role])
    render json: users, stats: :ok
  end

  def by_establishment
    users = User.joins(:establishments_users).where(establishments_users: { establishment_id: params[:establishment_id] })
    render json: users, status: :ok
  end


  def destroy
    user = User.find(params[:id])

    if user.destroy
      render json: {"status": "success"}, status: :ok
    else
      render json: {"status": "error", 'message': user.errors.full_messages}, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end


  def show
    user = User.find( params[:id] )
    render json: user, status: :ok
  end


  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: {"status": "success"}, status: :created

    else
      render json: {"status": "error", 'message': user.errors.full_messages}, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end


  private
  def user_params
    params.require(:user).permit( :email, :role, :password, :password_confimartion, :name )
  end
end
