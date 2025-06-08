require 'rails_helper'

RSpec.describe "/cart", type: :request do
  describe "POST /add_item" do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    before do
      host! "localhost"
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ cart_id: cart.id })
    end
  
    it 'acumula a quantidade ao adicionar o mesmo produto duas vezes' do
      post '/cart/add_item', params: { product_id: product.id, quantity: 1 }, as: :json
      post '/cart/add_item', params: { product_id: product.id, quantity: 1 }, as: :json

      cart_product = CartProduct.find_by(cart: cart, product: product)
      expect(cart_product.quantity).to eq(2)
    end
  end

  describe "DELETE /cart/:product_id" do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let!(:cart_product) { CartProduct.create(cart: cart, product: product, quantity: 1) }

    before do
      host! "localhost"
    end

    it 'deletes the cart product' do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ cart_id: cart.id })

      expect {
          delete "/cart/#{cart_product.id}"
        }.to change { CartProduct.count }.by(-1)
      end
  end
end