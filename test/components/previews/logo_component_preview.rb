# frozen_string_literal: true

class LogoComponentPreview < ViewComponent::Preview
  def default
    render(LogoComponent.new(title: 'Example component default'))
  end
end
