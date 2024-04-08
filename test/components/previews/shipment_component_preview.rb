# frozen_string_literal: true

class ShipmentComponentPreview < ViewComponent::Preview
  def default
    render(ShipmentComponent.new)
  end
end
