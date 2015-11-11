# -*- encoding : utf-8 -*-
class AnswersMigration < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :question_id
      t.integer :level_id
      t.string :value
    end

    remove_column :questions, :answer
  end

  def self.down
    add_column :questions, :answer, :string
    drop_table :answers
  end
end
