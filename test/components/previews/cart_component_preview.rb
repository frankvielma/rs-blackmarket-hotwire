# frozen_string_literal: true

class CartComponentPreview < ViewComponent::Preview
  def default
    render(CartComponent.new)
  end
end
