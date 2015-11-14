# -*- encoding : utf-8 -*-
class TeamMigration < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.integer :captain_id
      t.timestamps null: false
    end

    add_column :users, :team_id, :integer
  end

  def self.down
    remove_column :users, :team_id
    drop_table :teams
  end
end
