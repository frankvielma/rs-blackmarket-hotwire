# frozen_string_literal: true

# == Schema Information
#
# Table name: shipping_addresses
#
#  id          :bigint           not null, primary key
#  country     :string
#  city        :string
#  state       :string
#  line1       :string
#  line2       :string
#  postal_code :string
#  order_id    :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :shipping_address do
    country { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    line1 { 'MyString' }
    line2 { 'MyString' }
    postal_code { '12345' }
    order_id { '' }
  end
end
