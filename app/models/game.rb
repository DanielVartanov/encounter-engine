class Game < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :levels, :order => "position"
  has_many :logs, :order => "time"

  validates_presence_of :name,
    :message => "Вы не ввели название"

  validates_uniqueness_of :name,
    :message => "Игра с таким названием уже существует"

  validates_presence_of :description,
    :message => "Вы не ввели описание"

  validates_presence_of :author

  validate :game_starts_in_the_future

  validate :deadline_is_in_future
  validate :deadline_is_before_game_start
  
  named_scope :by, lambda { |author| { :conditions => { :author_id => author.id } } }

  def self.started
    Game.all.select { |game| game.started? }
  end

  def draft?
    self.is_draft
  end

  def started?
    self.starts_at.nil? ? false : Time.now > self.starts_at
  end

  def created_by?(user)
    user.author_of?(self)
  end

  def finished_teams
    GamePassing.of_game(self).finished.map(&:team)
  end

  def place_of(team)
    game_passing = GamePassing.of(team, self)
    return nil unless game_passing and game_passing.finished?

    count_of_finished_before = GamePassing.of_game(self).finished_before(game_passing.finished_at).count
    count_of_finished_before + 1
  end

  def self.notstarted
    Game.all.select { |game| !game.started? }
  end

protected

  def game_starts_in_the_future
    if self.starts_at and self.starts_at < Time.now
      self.errors.add(:starts_at, "Вы выбрали дату из прошлого. Так нельзя :-)")
    end
  end
  def deadline_is_in_future
    if self.registration_deadline and self.registration_deadline < Date.today
        self.errors.add(:registration_deadline,"Вы указали крайний срок регистрации из прошлого, так нельзя :-)")
    end
  end
  def deadline_is_before_game_start
    if self.registration_deadline and self.starts_at and self.registration_deadline > self.starts_at
      self.errors.add(:registration_deadline,"Вы указали крайний срок регистрации больше даты начала игры, так нельзя")
    end
  end
end