class GoldQuestionsMigration < ActiveRecord::Migration
  def self.up
    add_column :questions, :gold, :boolean, {:default => false}
  end

  def self.down
    remove_column :questions, :gold
  end
end
