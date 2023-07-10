class ShoppingCart < ApplicationRecord
  include AASM
  
  belongs_to :establishment
  belongs_to :table
  belongs_to :user
  has_many :shopping_cart

  enum status: {
    open: 1,
    payed: 2,
    expired: 98,
    closed: 99
  }

  aasm column: 'status', :enum => true do
    state :open, :initial => true
    state :payed, :expired, :closed

    event :pay do
      transitions :from => :open, :to => :payed, :guard => :if_open?
    end

    event :expire do
      transitions :from => :open, :to => :expired, :guard => :if_open?
    end

    event :close do
      transitions :from => [:open, :payed], :to => :closed, :guard => :if_open?
    end
  end

  def if_open?
    status == "open"
  end

  def can_close?
    cart_item = self.cart_items.where(status: ['doing', 'done', 'delivered'])
    return cart_item.size == 0
  end
end
