require Merb.root + '/lib/ee_strings'

class Question < ActiveRecord::Base
  belongs_to :level
  has_many :answers

  def correct_answer=(answer)
    self.answers.build(:value => answer)
  end

  def correct_answer
    self.answers.empty? ?
      nil :
      self.answers.first.value
  end

  def matches_any_answer(answer_value)
    self.answers.any? {|answer| answer.value.to_s.upcase_utf8_cyr == answer_value.to_s.upcase_utf8_cyr}
  end
end
