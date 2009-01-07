class Team < ActiveRecord::Base

  has_many :members, :class_name => "User"
  belongs_to :captain, :class_name => "User"

  before_save :adopt_captain

  def adopt_captain
    unless captain.nil?
      self.members << captain unless members.include?(captain)
    end
  end 

end