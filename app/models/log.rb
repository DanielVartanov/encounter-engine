# -*- encoding : utf-8 -*-
class Log < ActiveRecord::Base
  belongs_to :game

  scope :of_game, lambda { |game| { :conditions => { :game_id => game.id } } }
  scope :of_team, lambda { |team| { :conditions => { :team => team.name } } }
  scope :of_level, lambda { |level| { :conditions => { :level => level.name } } }

end
