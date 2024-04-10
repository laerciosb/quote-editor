# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/index', type: :view do
  before do
    assign(:quotes, [
             Quote.create!(
               name: 'Name'
             ),
             Quote.create!(
               name: 'Name'
             )
           ])
  end

  it 'renders a list of quotes' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
  end
end
