# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogoComponent, type: :component do
  it 'renders the black logo when type is black' do
    render_inline(described_class.new(title: 'My Title', type: 'black'))
    image = page.find_link.find('img')

    expect(page).to have_xpath("//h1[@class='sr-only' and text()='My Title']")
    expect(image[:src]).to include('bm_logo')
  end

  it 'renders the white logo when type is white' do
    render_inline(described_class.new(title: 'My Title', type: 'white'))
    image = page.find_link.find('img')

    expect(page).to have_xpath("//h1[@class='sr-only' and text()='My Title']")
    expect(image[:src]).to include('logo_header')
  end
end
