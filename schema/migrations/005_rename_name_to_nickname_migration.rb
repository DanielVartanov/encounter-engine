# -*- encoding : utf-8 -*-
class RenameNameToNicknameMigration < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :nickname
  end

  def self.down
    rename_column :users, :nickname, :name
  end
end
