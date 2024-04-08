# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  def initialize(type:)
    @type = type
  end
end
