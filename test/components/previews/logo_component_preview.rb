# frozen_string_literal: true

class LogoComponentPreview < ViewComponent::Preview
  layout 'component_preview'

  def default
    render(LogoComponent.new(title: 'Example component default'))
  end
end
