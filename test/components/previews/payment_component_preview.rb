# frozen_string_literal: true

class PaymentComponentPreview < ViewComponent::Preview
  def default
    render(PaymentComponent.new)
  end
end
