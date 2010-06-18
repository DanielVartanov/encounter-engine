class RequestMigration < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.integer :game_id
      t.integer :team
      t.string :status
    end
  end

  def self.down
    drop_table :requests
  end
end