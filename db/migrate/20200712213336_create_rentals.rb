# frozen_string_literal: true

class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.string :title
      t.decimal :price
      t.text :description
      t.timestamps null: false
    end
  end
end
