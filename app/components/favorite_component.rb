# frozen_string_literal: true

class FavoriteComponent < ViewComponent::Base
  def initialize(product_id:)
    @product_id = product_id
  end

  def favorite(status)
    if status == 'on'
      favorite? ? '' : 'hidden'
    else
      favorite? ? 'hidden' : ''
    end
  end

  def favorite?
    FavoriteProduct.where(user_id: helpers.current_user.id, product_id: @product_id).any?
  end
end
