class Api::V1::Private::ShoppingCartsController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    shopping_carts = ShoppingCart.where(establishment_id: current_user.establishment_ids, status: 'open').order(:id)
    render json: {shopping_carts: shopping_carts}, status: 200
  end

  def create
    #result = ShoppingCartService.create params, current_user
    #render json: result[0].to_json, status: result[1][:status]

    render json: {msg: 'ok'}, status: :ok
  end

  def update_status
    result = ShoppingCartService.update_status params
    render json: result[0], status: result[1][:status]
  end

  def opened
    result = ShoppingCartService.opened params, current_user
    render json: result[0], status: result[1][:status]
  end

  def details_shopping_cart

    shopping_carts = ShoppingCart.find(params[:shopping_cart_id])
    products = []
    orders = Order.where(shopping_cart_id: shopping_carts.id )

    orders.each do |order|
      product = Product.find(order.product_id)
      product_params = {
        id: product.id,
        establishment_id: product.establishment_id,
        description: product.details['description'],
        name: product.details['name'],
        preparation_time: product.details['preparation_time'],
        type: product.details['type'],
        price: product.price,
        shopping_cart_total: shopping_carts.total
      }
      products << product_params
    end
    render json: { products: products }, status: 200
  end

  def orders_by_user
    shopping_cart = ShoppingCart.find( params[:shopping_cart_id] )

    shopping_cart.orders.each do |order|
      p order.id
    end

    render json: shopping_cart.orders, status: :ok

  rescue => e
    p e
    render json: {'status': 'error', 'message': e.to_s}, status: :internal_server_error
  end

end
