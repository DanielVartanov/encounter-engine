class GoldAnswersMigration < ActiveRecord::Migration
  def self.up
    add_column :answers, :gold, :boolean, {:default => false}
  end

  def self.down
    remove_column :answers, :gold
  end
end
