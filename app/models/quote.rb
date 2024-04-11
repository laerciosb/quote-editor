# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :name, presence: true

  broadcasts_to ->(_) { 'quotes' }, inserts_by: :prepend
end
