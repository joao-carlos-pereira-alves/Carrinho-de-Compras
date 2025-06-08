class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product, optional: true # For handle error message

  before_validation :set_prices

  validates :cart_id, :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0, message: 'deve ser maior que zero' }
  validate :product_must_exist 

  after_save :update_cart_total
  after_destroy :update_cart_total
  
  private

  def set_prices
    return if product.blank? || quantity.blank?

    self.unit_price = product.price
    self.total_price = unit_price * quantity
  end

  def product_must_exist
    errors.add(:product, 'não existe') unless Product.exists?(product_id)
  end

  def update_cart_total
    cart.update(total_price: cart.cart_products.sum(:total_price))
  end
end