# frozen_string_literal: true

class CreateHints < ActiveRecord::Migration[6.1]
  def change
    create_table :hints do |t|
      t.references :level, foreign_key: true
      t.string :text
      t.integer :delay_in_minutes
      t.timestamps
    end
  end
end
