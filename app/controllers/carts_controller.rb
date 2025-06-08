class CartsController < ApplicationController
  before_action :set_cart, only: %i[show add_item remove_item]
  before_action :set_cart_product, only: [:remove_item]
  before_action :validate_cart_params, only: [:add_item]

  def show
    render json: cart_payload(@cart), status: :ok
  end

  def add_item
    item = @cart.add_product(cart_params[:product_id], cart_params[:quantity])

    if item.persisted?
      render json: cart_payload(@cart), status: :ok
    else
      render json: { errors: item.errors.messages }, status: :unprocessable_entity
    end
  end

  def remove_item
    if @cart_product
      @cart_product.destroy
      render json: cart_payload(@cart), status: :ok
    else
      render json: { errors: ['Produto não encontrado no carrinho'] }, status: :not_found
    end
  end

  private

  def find_or_create_cart
    return Cart.find(session[:cart_id]) if session[:cart_id] && Cart.exists?(session[:cart_id])

    cart = Cart.create!(total_price: 0)
    session[:cart_id] = cart.id
    cart
  end

  def cart_payload(cart)
    {
      id: cart.id,
      total_price: cart.total_price,
      items: cart.cart_products.map do |item|
        {
          id: item.id,
          product_id: item.product_id,
          quantity: item.quantity,
          unit_price: item.unit_price,
          total_price: item.total_price
        }
      end
    }
  end

  def set_cart
    @cart = find_or_create_cart
  end

  def validate_cart_params
    params.require(:product_id)
    params.require(:quantity)
  rescue ActionController::ParameterMissing => e
    message = case e.param
          when :product_id then 'product_id é obrigatório'
          when :quantity then 'quantity é obrigatório'
          else e.message
          end
    render json: { errors: [message] }, status: :unprocessable_entity and return
  end

  def cart_params
    params.permit(:product_id, :quantity)
  end

  def set_cart_product
    @cart_product = @cart.cart_products.find_by(id: params[:product_id])
  end
end
