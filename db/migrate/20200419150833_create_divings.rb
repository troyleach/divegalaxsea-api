# frozen_string_literal: true

class CreateDivings < ActiveRecord::Migration[6.0]
  def change
    create_table :divings do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.text :description

      t.timestamps
    end
  end
end
