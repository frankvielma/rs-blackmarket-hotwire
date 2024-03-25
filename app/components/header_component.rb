# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(featured:)
    @featured = featured
  end
end
