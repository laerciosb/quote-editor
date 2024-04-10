# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :name, presence: true

  broadcasts_to ->(_quote) { 'quotes' }, inserts_by: :prepend
end
