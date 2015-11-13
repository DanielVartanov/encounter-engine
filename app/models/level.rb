# coding: utf-8
require Merb.root + '/lib/ee_strings'

class Level < ActiveRecord::Base
  acts_as_list :scope => :game

  belongs_to :game
  has_many :questions
  has_many :answers
  has_many :hints, -> { order('delay ASC') }

  validates_presence_of :name,
    :message => "Вы не ввели название задания"

  validates_presence_of :text,
    :message => "Вы не ввели текст задания"

  validates_presence_of :game

  scope :of_game, ->(game) { where(game_id: game) }

  def next
    lower_item
  end

  def correct_answer=(answer)
    self.questions.build(:correct_answer => answer)
  end

  def correct_answer
    self.questions.empty? ?
      nil :
      self.questions.first.answers.first.value
  end

  def multi_question?
    self.questions.count > 1
  end

  def find_question_by_answer(answer_value)
    self.questions.detect do |question|
      question.answers.any? { |answer| answer.value.to_s.upcase_utf8_cyr == answer_value.to_s.upcase_utf8_cyr }
    end
  end
end
