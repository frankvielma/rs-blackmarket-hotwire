# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def search
    @categories = Category.where('name ilike ?', "%#{params[:name]}%").order(:name).distinct
    respond_to do |format|
      format.html  { render partial: 'categories/index' }
      format.json  { render json: @categories }
    end
  end
end
