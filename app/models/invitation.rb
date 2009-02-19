class Invitation < ActiveRecord::Base
  belongs_to :from_team, :class_name => "Team"
  belongs_to :to_user, :class_name => "User"
end