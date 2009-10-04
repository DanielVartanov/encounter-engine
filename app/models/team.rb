class Team < ActiveRecord::Base

  has_many :members, :class_name => "User"
  belongs_to :captain, :class_name => "User"

  validates_uniqueness_of :name,
    :message => "Команда с таким названием уже существует"

  validates_presence_of :name,
    :message => "Название команды должно быть непустым"

  before_save :adopt_captain

  def current_level_in(game)
    game_passing = GamePassing.first :conditions => { :team_id => self.id, :game_id => game.id }
    game_passing.try :current_level
  end

protected

  def adopt_captain
    unless captain.nil?
      self.members << captain unless members.include?(captain)
    end
  end 
end