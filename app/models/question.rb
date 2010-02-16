class Question < ActiveRecord::Base
	belongs_to :level

  before_save :strip_spaces

  validates_presence_of :answer

protected

  def strip_spaces
    self.answer.strip!
  end
end