# frozen_string_literal: true

class CreateVacations < ActiveRecord::Migration[6.0]
  def change
    create_table :vacations do |t|
      t.references :user, index: true, foreign_key: true
      t.text :dates_array, array: true, default: []
      t.jsonb :diving_objects, default: {}
      t.jsonb :training_objects, default: {}
      t.integer :number_of_divers
      t.string :resort
      t.timestamps null: false
    end
  end
end
