class UserMigration < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :crypted_password
      t.string :salt
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
