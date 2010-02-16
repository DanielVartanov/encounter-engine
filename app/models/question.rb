class Question < ActiveRecord::Base
	belongs_to :level

  before_save :strip_spaces

  validates_presence_of :answer

  validates_uniqueness_of :answer,
    :scope => [:level_id],
    :message => "Такой код уже есть в задании"

protected

  def strip_spaces
    self.answer.strip!
  end
end