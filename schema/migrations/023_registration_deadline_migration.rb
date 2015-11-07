# -*- encoding : utf-8 -*-
class RegistrationDeadlineMigration < ActiveRecord::Migration
  def self.up
    add_column :games, :registration_deadline, :datetime
  end

  def self.down
    remove_column :games, :registration_deadline
  end
end
