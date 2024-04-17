# frozen_string_literal: true

class CartComponent < ViewComponent::Base
  def initialize(product:)
    @product = product
  end
end
