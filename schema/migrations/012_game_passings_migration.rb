class GamePassingsMigration < ActiveRecord::Migration
  def self.up
    create_table :game_passings do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :current_level_id
      t.timestamps
    end
  end

  def self.down
    drop_table :game_passings
  end
end
