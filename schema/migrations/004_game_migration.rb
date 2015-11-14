# -*- encoding : utf-8 -*-
class GameMigration < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name
      t.string :description
      t.integer :author_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :games
  end
end
