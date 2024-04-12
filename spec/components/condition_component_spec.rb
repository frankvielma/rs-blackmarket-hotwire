# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConditionComponent, type: :component do
  describe 'Condition component' do
    before do
      render_inline(described_class.new)
    end

    it 'renders the shipment component' do
      text = page.find_xpath('//div[@class="font-bold"]').text
      expect(text).to eq('Condition:')
    end
  end
end
