# frozen_string_literal: true

class CreateLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :levels do |t|
      t.string :name
      t.string :answer
      t.references :game, foreign_key: true
      t.timestamps
    end
  end
end
