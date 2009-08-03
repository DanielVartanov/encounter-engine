class AddNameToLevelsMigration < ActiveRecord::Migration
  def self.up
    add_column :levels, :name, :string
  end

  def self.down
    remove_column :levels, :name
  end
end