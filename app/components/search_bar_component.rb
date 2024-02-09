# frozen_string_literal: true

class SearchBarComponent < ViewComponent::Base
  def initialize(placeholder:)
    @placeholder = placeholder
  end
end
