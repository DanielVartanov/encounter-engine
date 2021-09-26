class Team < ApplicationRecord
  has_many :plays
  has_many :members, class_name: 'User'
end
