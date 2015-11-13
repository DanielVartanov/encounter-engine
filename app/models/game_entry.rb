# -*- encoding : utf-8 -*-
class GameEntry < ActiveRecord::Base
  belongs_to :game
  belongs_to :team

  validates_presence_of :game,
    :message => "Вы не выбрали игру"

  validates_presence_of :team_id,
    :message => "Вы не указали команду"

  scope :of_game, ->(game) { where(game_id: game.id) }
  scope :of_team, ->(team) { where(team_id: team.id) }
  scope :with_status, ->(status) { where(status: status) }

  def self.of(team, game)
    self.of_team(team).of_game(game).first
  end

  def reopen!
    self.status = "new"
    save!
  end

  def accept!
    self.status = "accepted"
    save!
  end

  def reject!
    self.status = "rejected"
    save!
  end

  def recall!
    self.status = "recalled"
    save!
  end

  def cancel!
    self.status = "canceled"
    save!
  end
end
