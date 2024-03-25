# frozen_string_literal: true

class FavoriteComponent < ViewComponent::Base
  def initialize(product_id:)
    @product_id = product_id
  end

  def favorite_off
    favorite? ? 'hidden' : ''
  end

  def favorite_on
    favorite? ? '' : 'hidden'
  end

  def favorite?
    FavoriteProduct.where(user_id: helpers.current_user.id, product_id: @product_id).any?
  end
end
