# frozen_string_literal: true

class LogoComponentPreview < ViewComponent::Preview
  def black_logo
    render LogoComponent.new(title: 'Logo black', type: 'black')
  end

  def white_logo
    render LogoComponent.new(title: 'Logo white', type: 'white')
  end
end
