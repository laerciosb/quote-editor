# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/form', type: :view do
  before do
    assign(:quote, quote)
  end

  context 'with new' do
    let(:quote) { Quote.new(name: 'MyString') }

    it 'renders new quote form' do
      render

      assert_select 'form[action=?][method=?]', quotes_path, 'post' do
        assert_select 'input[name=?]', 'quote[name]'
      end
    end
  end

  context 'when edit' do
    let(:quote) { Quote.create!(name: 'MyString') }

    it 'renders the edit quote form' do
      render

      assert_select 'form[action=?][method=?]', quote_path(quote), 'post' do
        assert_select 'input[name=?]', 'quote[name]'
      end
    end
  end
end
