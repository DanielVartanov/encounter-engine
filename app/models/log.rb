class Log < ActiveRecord::Base
  belongs_to :game

  named_scope :of_game, lambda { |game| { :conditions => { :game_id => game.id } } }
  named_scope :of_team, lambda { |team| { :conditions => { :team => team.name } } }
  named_scope :of_level, lambda { |level| { :conditions => { :level => level.name } } }
  
end