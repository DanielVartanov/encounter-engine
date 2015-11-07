# -*- encoding : utf-8 -*-
class QuestionMigration < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
    	t.string :questions
      t.string :answer
      t.integer :level_id
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
