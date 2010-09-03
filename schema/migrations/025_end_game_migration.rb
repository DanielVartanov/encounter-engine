class EndGameMigration < ActiveRecord::Migration
  def self.up
    add_column :game_passings, :status, :string
    add_column :games, :author_finished_at, :datetime
  end

  def self.down
    remove_column :game_passings, :status
    remove_column :games, :author_finished_at
  end
end
