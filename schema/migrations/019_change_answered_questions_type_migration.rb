# -*- encoding : utf-8 -*-
class ChangeAnsweredQuestionsTypeMigration < ActiveRecord::Migration
  def self.up
    change_column :game_passings, :answered_questions, :text
  end

  def self.down
    change_column :game_passings, :answered_questions, :string
  end
end
