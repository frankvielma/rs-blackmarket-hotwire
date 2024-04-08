# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  parent_category_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_categories_on_name_and_parent_category_id  (name,parent_category_id) UNIQUE
#
class Category < ApplicationRecord
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_category_id',
                           inverse_of: :parent_category, dependent: :nullify
  has_many :products, dependent: :restrict_with_error
  belongs_to :parent_category, class_name: 'Category', optional: true, inverse_of: :subcategories

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :parent_category_id }
end
