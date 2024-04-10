# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/new', type: :view do
  before do
    assign(:quote, Quote.new(
      name: 'MyString'
    ))
  end

  it 'renders new quote form' do
    render

    assert_select 'form[action=?][method=?]', quotes_path, 'post' do
      assert_select 'input[name=?]', 'quote[name]'
    end
  end
end
