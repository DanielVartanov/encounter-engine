class AnswersMigration < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
    	t.integer :question_id
      t.integer :level_id
      t.string :value
    end

    Question.reset_column_information
    questions = Question.all
    questions.each do |q|
      Answer.create! :value => q.answer, :question_id => q.id, :level_id => q.level_id
    end

    remove_column :questions, :answer
  end

  def self.down
    add_column :questions, :answer, :string

    Question.reset_column_information
    Answer.reset_column_information
    questions = Question.all
    questions.each do |q|
      answer = Answer.of_question(q).first
      q.answer = answer.value
      q.save!
    end

    drop_table :answers
  end
end