# frozen_string_literal: true

class QuantityUpdaterComponentPreview < ViewComponent::Preview
  def default
    render(QuantityUpdaterComponent.new)
  end
end
