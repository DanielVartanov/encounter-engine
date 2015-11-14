# -*- encoding : utf-8 -*-
class InvitationMigration < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :to_team_id
      t.integer :for_user_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :invitations
  end
end
