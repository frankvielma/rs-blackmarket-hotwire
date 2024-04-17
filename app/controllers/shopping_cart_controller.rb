# frozen_string_literal: true

class ShoppingCartController < ApplicationController
  def index
    cart_items = ShoppingCart.includes(:product).where(user_id: current_user)
    total = cart_items.sum { |item| item.product.unit_price_cents } / 100.0

    partial = cart_items.present? ? 'shopping_cart/search_results' : 'shopping_cart/empty'
    render turbo_stream: [
      turbo_stream.replace('toggle-shopping-product', ProductButtonComponent.new),
      turbo_stream.update('main', partial:, locals: { cart_items:, total: })
    ]
  end
end
