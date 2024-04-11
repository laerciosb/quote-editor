# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :name, presence: true

  # broadcast_prepend_to 'quotes', partial: 'quotes/quote', locals: { quote: self }, target: 'quotes'
  after_create_commit -> { broadcast_prepend_to 'quotes' }
  after_update_commit -> { broadcast_replace_to 'quotes' }
  # after_create_commit -> { broadcast_prepend_later_to 'quotes' }
  # after_update_commit -> { broadcast_replace_later_to 'quotes' }
  after_destroy_commit -> { broadcast_remove_to 'quotes' }
  # broadcasts_to ->(_) { 'quotes' }, inserts_by: :prepend
end
