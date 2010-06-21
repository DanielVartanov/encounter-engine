class GameEntry < ActiveRecord::Base
  belongs_to :game, :class_name => "Game"

  validates_presence_of :game,
    :message => "Вы не выбрали игру"

  validates_presence_of :team,
    :message => "Вы не указали команду"

end