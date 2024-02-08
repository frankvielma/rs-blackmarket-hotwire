# frozen_string_literal: true

class ProductComponentPreview < ViewComponent::Preview
  def default
    render(ProductComponent.new)
  end
end
