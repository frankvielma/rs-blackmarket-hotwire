# frozen_string_literal: true

class DropdownComponentPreview < ViewComponent::Preview
  def default
    render(DropdownComponent.new)
  end
end
