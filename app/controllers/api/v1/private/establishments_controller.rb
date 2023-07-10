class Api::V1::Private::EstablishmentsController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    establishments = Establishment.all
    render json: establishments, status: :ok
  end


  def by_user
    establishments = Establishment.joins(:establishments_users).where(establishments_users: { user_id: current_user.id})
    render json: establishments, status: :ok
  end


  def create
    establishment_params = JSON.parse(params[:establishment])

    establishment = Establishment.new( establishment_params )
    establishment.cover.attach(params[:cover])
    establishment.avatar.attach(params[:avatar])

    if establishment.save
      address_params = JSON.parse(params[:address])
      address = Address.new( address_params )
      establishment.address = address

      render json: {"status": "success"}, status: :created
    else
      render json: {"status": "error", 'message': establishment.errors.full_messages}, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end


  def destroy
    establishment = Establishment.find(params[:id])

    if establishment.destroy
      render json: {"status": "success"}, status: :ok
    else
      render json: {"status": "error", 'message': establishment.errors.full_messages}, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end


  def show
    establishment = Establishment.find(params[:id])
    render json: establishment, status: :ok
  end


  def update
    establishment_params = JSON.parse(params[:establishment])
    establishment = Establishment.find( params[:id] )

    unless params[:cover] == ''
      establishment.cover.attach(params[:cover])
    end

    unless params[:avatar] == ''
      establishment.avatar.attach(params[:avatar])
    end

    if establishment.update(establishment_params)

      address_params = JSON.parse(params[:address])
      address = Address.find( address_params['id'] )
      address.update_attributes(address_params)
      render json: {"status": "success"}, status: :created

    else
      render json: {"status": "error", 'message': establishment.errors.full_messages}, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end


  def favorite_establishment 
    establishment = Establishment.find(params[:establishment_id])
    user = current_user
    favorite_establishment = FavoritesEstablishment.new(establishment: establishment, user: user)
    favorite_establishment.save

  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end

  def by_favorite
    user = current_user
    establishments = []

    user.favorites_establishments.each do |fav_estab|
      establishments << fav_estab.establishment
    end
    
    render json: establishments, status: :ok    
    
  rescue => e
    Rails.logger.error '====================== ERROR ======================'
    Rails.logger.error e.message
    render json: {"status": "error", "message": e.message}, status: :internal_server_error
  end
end
