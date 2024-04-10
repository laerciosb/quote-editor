# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[7.1]
  def change
    create_table :quotes, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
