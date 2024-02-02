# frozen_string_literal: true

class AddUniqueIndexToCategoriesName < ActiveRecord::Migration[7.1]
  def change
    add_index :categories, %i[name parent_category_id], unique: true
  end
end
