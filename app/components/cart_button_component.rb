# frozen_string_literal: true

class CartButtonComponent < ViewComponent::Base
  def initialize(product:)
    @product = product
  end
end
