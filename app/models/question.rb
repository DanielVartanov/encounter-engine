class Question < ActiveRecord::Base
  belongs_to :level
  has_many :answers, :dependent => :destroy

  def correct_answer=(answer)
    if self.answers.empty?
      self.answers.build(:value => answer)
    else
      self.answers.first.value = answer
    end
  end

  def correct_answer
    self.answers.empty? ? nil : self.answers.first.value
  end

  def matches_any_answer(answer_value)
    require "lib/ee_strings.rb"
    self.answers.any? { |answer| answer.value.to_s.upcase_utf8_cyr == answer_value.to_s.upcase_utf8_cyr }
  end
end