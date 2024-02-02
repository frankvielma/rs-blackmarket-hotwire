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
FactoryBot.define do
  factory :category do
    name { Faker::Commerce.department }

    factory :category_with_products do
      transient do
        product_count { 3 }
      end

      after(:create) do |category, evaluator|
        create_list(:product, evaluator.product_count, category:)
      end
    end
  end
end
