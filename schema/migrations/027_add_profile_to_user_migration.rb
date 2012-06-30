class AddProfileToUserMigration < ActiveRecord::Migration
  def self.up
    add_column :users, :jabber_id, :string
    add_column :users, :icq_number, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :phone_number, :string
  end

  def self.down
    remove_column :users, :jabber_id
    remove_column :users, :icq_number
    remove_column :users, :date_of_birth
    remove_column :users, :phone_number
  end
end
