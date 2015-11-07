# -*- encoding : utf-8 -*-
class GameEntryMigration < ActiveRecord::Migration
  def self.up
    create_table :game_entries do |t|
      t.integer :game_id
      t.integer :team_id
      t.string :status
    end
  end

  def self.down
    drop_table :game_entries
  end
end
