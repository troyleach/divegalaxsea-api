# frozen_string_literal: true

class CreateSpecialties < ActiveRecord::Migration[6.0]
  def change
    create_table :specialties do |t|
      t.string :title
      t.decimal :price
      t.text :description
      t.timestamps null: false
    end
  end
end
