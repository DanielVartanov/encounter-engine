# -*- encoding : utf-8 -*-
class AddStartsAtColumnToGameMigration < ActiveRecord::Migration
  def self.up
    add_column :games, :starts_at, :datetime
  end

  def self.down
    remove_column :games, :starts_at
  end
end
