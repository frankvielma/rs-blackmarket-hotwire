# frozen_string_literal: true

class ShoppingCartController < ApplicationController
  def index
    @cart_items = ShoppingCart.includes(:product).where(user_id: current_user)
    @total = @cart_items.sum { |item| item.product.unit_price_cents } / 100.0
  end
end
