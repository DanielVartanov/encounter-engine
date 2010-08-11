class GameEntry < ActiveRecord::Base
  belongs_to :game, :class_name => "Game"
  belongs_to :team, :class_name => "Team"

  validates_presence_of :game,
    :message => "Вы не выбрали игру"

  validates_presence_of :team_id,
    :message => "Вы не указали команду"

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