# frozen_string_literal: true

class CreateTrainings < ActiveRecord::Migration[6.0]
  def change
    create_table :trainings do |t|
      t.string :title
      t.decimal :price
      t.text :description
      t.timestamps null: false
    end
  end
end
