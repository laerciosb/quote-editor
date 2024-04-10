# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/edit', type: :view do
  let(:quote) do
    Quote.create!(
      name: 'MyString'
    )
  end

  before do
    assign(:quote, quote)
  end

  it 'renders the edit quote form' do
    render

    assert_select 'form[action=?][method=?]', quote_path(quote), 'post' do
      assert_select 'input[name=?]', 'quote[name]'
    end
  end
end
