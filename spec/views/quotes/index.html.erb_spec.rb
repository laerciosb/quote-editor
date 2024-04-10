# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/index', type: :view do
  before do
    assign(:quotes, [Quote.create!(name: 'Name'), Quote.create!(name: 'Name')])
  end

  it 'renders a list of quotes' do
    render

    assert_select('#new_quote', count: 1, text: '')
    assert_select('#quotes .quote', count: 2, text: Regexp.new('Name'.to_s))
  end
end
