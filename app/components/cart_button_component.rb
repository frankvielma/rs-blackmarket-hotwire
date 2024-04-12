# frozen_string_literal: true

class CartButtonComponent < ViewComponent::Base
  def initialize(product:)
    @product = product
  end

  def shopping_cart?
    shopping_cart = ShoppingCart.where(user_id: helpers.current_user.id, product_id: @product.id).any?
    shopping_cart ? 'text-black bg-white border' : 'text-white bg-black'
  end
end
