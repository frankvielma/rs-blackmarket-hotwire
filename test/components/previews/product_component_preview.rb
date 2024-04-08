# frozen_string_literal: true

class ProductComponentPreview < ViewComponent::Preview
  def default
    render(ProductComponent.new(product: Product.first))
  end
end
