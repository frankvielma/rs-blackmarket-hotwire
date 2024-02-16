# frozen_string_literal: true

class FilterMobileComponentPreview < ViewComponent::Preview
  def default
    render(FilterMobileComponent.new)
  end
end
