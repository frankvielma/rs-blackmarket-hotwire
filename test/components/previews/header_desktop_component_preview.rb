# frozen_string_literal: true

class HeaderDesktopComponentPreview < ViewComponent::Preview
  def default
    render(HeaderDesktopComponent.new)
  end
end
