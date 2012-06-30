class TestGameMigration < ActiveRecord::Migration
 def self.up
  add_column :games, :is_testing, :boolean, :null => false, :default => false
  add_column :games, :test_date, :datetime
 end

 def self.down
  remove_column :games, :is_testing
  remove_column :games, :test_date
 end
end
