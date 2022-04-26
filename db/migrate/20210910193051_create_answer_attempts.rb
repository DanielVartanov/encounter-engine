# frozen_string_literal: true

class CreateAnswerAttempts < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_attempts do |t|
      t.string :answer
      t.references :play, foreign_key: true
      t.references :level, foreign_key: true
      t.timestamps
    end
  end
end
