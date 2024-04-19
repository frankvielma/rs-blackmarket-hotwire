# frozen_string_literal: true

class QuantityUpdaterComponent < ViewComponent::Base
  def initialize(product:)
    @product = product
  end

  def quantity
    @product.shopping_carts.first.line_items.first.quantity
  end
end
