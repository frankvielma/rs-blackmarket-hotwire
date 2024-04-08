# frozen_string_literal: true

class DiscountComponentPreview < ViewComponent::Preview
  def default
    render(DiscountComponent.new)
  end
end
