class AddAnsweredQuestionsToGamePassingMigration < ActiveRecord::Migration
  def self.up
    add_column :game_passings, :answered_questions, :string
  end

  def self.down
    remove_column :game_passings, :answered_questions
  end
end
