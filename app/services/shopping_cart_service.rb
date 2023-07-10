class ShoppingCartService

  def self.create(params, current_user)
    table = Table.find_by( token: params[:table_token] )
  

    unless table.nil?
      shopping_carts = ShoppingCart.where(status: 'open', user: current_user)

      unless shopping_carts.size == 0 || shopping_carts.nil?
        shopping_cart = shopping_carts[0]
        return {
          'status': 'error',
          'message': 'Você já possui uma comanda aberta',
          'shopping_cart_id': shopping_cart.id,
          'establishment': shopping_cart.establishment.name,
          'can_close': shopping_cart.can_close?},
          {status: :conflict}
      end

      empty_tables = ShoppingCart.where( table_id: table[:id])
      aux_empty = true
      empty_tables.each do |empty_table|
        
        if empty_table[:status] === 'open'
          Rails.logger.info('a')
          aux_empty = false
        end
      end
      
      shopping_cart = ShoppingCart.new
      shopping_cart.establishment = table.establishment
      shopping_cart.user = current_user
      shopping_cart.table = table
      

      if aux_empty === true && shopping_cart.save
        return {'status': 'success', 'message': 'Comanda aberta', 'shopping_cart': shopping_cart, 'establishment': table.establishment}, {status: :created}
      else
        return {'status': 'error', 'message': 'Erro ao abrir a comanda'}, {status: :internal_server_error}
      end
    else
      return {'status': 'error', 'message': 'Estabelecimento não cadastrado'}, {status: :not_found}
    end

  rescue => e
    p e
    return {'status': 'error', 'message': e.to_s}, {status: :internal_server_error}
  end


  def self.update_status(params)
    Rails.logger.info("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
    Rails.logger.info("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
    
    shopping_cart = ShoppingCart.find(params[:shopping_cart_id])
    orders =  Order.where(shopping_cart_id: shopping_cart.id)
    aux = true

    if params[:action_status] === 'close'

      orders.each do |order|
        if order.status === 'open' || order.status === 'canceled_by_user' || order.status === 'canceled_by_establishment'
          p 'OK'
        else
          aux = false
        end
      end

      if aux === true
        orders.each do |order|
          order.update( status: 5)
          order.save
          Rails.logger.info( order.status )
        end
      end
    end

    if params[:action_status] == 'pay'
      orders.each do |order|
        if order.status === 'delivered'
          aux = true
        else
          aux = false
        end
      end
    end

    if aux == true
      shopping_cart.aasm.fire(params[:action_status].to_sym)

      if shopping_cart.save
        return {'status': 'success', 'message': 'Comanda alterada', 'shopping_cart': shopping_cart}, {status: :ok}
      end
    else
      return {'status': 'error', 'message': order.errors.full_messages}, {status: :internal_server_error}
    end

    return {'status': 'error', 'message': order.errors.full_messages}, {status: :internal_server_error}
  end



  def self.opened(params, current_user)
    establishment = Establishment.find( params[:establishment_id] )

    unless establishment.nil?
      shopping_carts = ShoppingCart.where(status: 'open', user: current_user)

      if shopping_carts.size > 0
        return {'status': 'success', 'message': 'Comanda aberta encontrada', 'shopping_cart': shopping_carts[0], 'establishment': establishment, 'can_close': shopping_carts[0].can_close?}, {status: :ok}
      else
        return {'status': 'error', 'message': "Nenhuma comanda aberta."}, {status: :not_found}
      end
    end

  rescue => e
    p e
    return {'status': 'error', 'message': e.to_s}, {status: :internal_server_error}
  end
end
