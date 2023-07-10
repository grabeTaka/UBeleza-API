class CartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product

  enum status: {
    open: 1,
    making: 2,
    canceled: 98,
    closed: 99
  }
end
