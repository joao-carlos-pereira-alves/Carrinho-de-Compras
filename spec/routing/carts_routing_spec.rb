require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe 'routes' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let!(:cart_product) { CartProduct.create(cart: cart, product: product, quantity: 1) }

    it 'routes to #show' do
      expect(get: '/cart').to route_to('carts#show')
    end

    it 'routes to #create' do
      expect(post: '/cart/add_item').to route_to('carts#add_item')
    end

    it 'routes to #add_item via POST' do
      expect(post: '/cart/add_item').to route_to('carts#add_item')
    end

    it 'routes to #remove_item via DELETE' do
      expect(delete: "/cart/#{cart_product.id}").to route_to('carts#remove_item', product_id: cart_product.id.to_s)
    end
  end
end 
