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
require 'rails_helper'

RSpec.describe Category do
  # Validations
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:parent_category_id) }

    it 'does not allow deletion with associated products' do
      category = create(:category_with_products)
      expect(category.destroy).to be(false)
      expect(category.errors[:base]).to include('Cannot delete record because dependent products exist')
    end

    it 'enforces uniqueness of name within parent category scope' do
      parent_category = create(:category)
      create(:category, name: 'Electronics', parent_category:)
      category2 = build(:category, name: 'electronics', parent_category:)
      category3 = build(:category, name: 'Electronics')

      expect(category2).not_to be_valid
      expect(category2.errors[:name]).to include('has already been taken')

      expect(category3).to be_valid
    end
  end

  # Associations
  describe 'associations' do
    it {
      expect(subject).to have_many(:subcategories).class_name('Category')
                                                  .inverse_of(:parent_category).dependent(:nullify)
    }

    it { is_expected.to have_many(:products).dependent(:restrict_with_error) }
    it { is_expected.to belong_to(:parent_category).class_name('Category').optional.inverse_of(:subcategories) }
  end

  # Hierarchical relationships
  describe 'hierarchical relationships' do
    it 'can have subcategories' do
      parent = create(:category)
      child = create(:category, parent_category: parent)
      expect(parent.subcategories).to include(child)
    end

    it 'can belong to a parent category' do
      parent = create(:category)
      child = create(:category, parent_category: parent)
      expect(child.parent_category).to eq(parent)
    end
  end
end
