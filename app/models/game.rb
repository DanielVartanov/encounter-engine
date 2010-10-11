class Game < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :levels, :order => "position"
  has_many :logs, :order => "time"
  has_many :game_entries, :class_name => "GameEntry"
  has_many :game_passings, :class_name => "GamePassing"

  validates_presence_of :name,
                        :message => "Вы не ввели название"

  validates_uniqueness_of :name,
                          :message => "Игра с таким названием уже существует"

  validates_presence_of :description,
                        :message => "Вы не ввели описание"

  validates_numericality_of :max_team_number, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10000, :allow_nil => true,
                        :message => "Вы некорректно указали ограничение на количество команд в игре"


  validates_presence_of :author

  validate :game_starts_in_the_future
  validate :valid_max_num

  validate :deadline_is_in_future
  validate :deadline_is_before_game_start

  named_scope :by, lambda { |author| {:conditions =>{:author_id => author.id}} }
  named_scope :non_drafts, :conditions => {:is_draft => false}
  named_scope :finished, :conditions => ['author_finished_at IS NOT NULL']

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
    Game.all.select { |game| !game.draft? && !game.started? }
  end

  def free_place_of_team!
    if self.requested_teams_number>0
      self.requested_teams_number-=1
      self.save
    end
  end

  def reserve_place_for_team!
    self.requested_teams_number+=1;
    self.save
  end

  def can_request?
    self.requested_teams_number < self.max_team_number
    Game.all.select { |game| !game.started? }
  end

  def finish_game!
    self.author_finished_at = Time.now
    self.save!
  end

  def author_finished?
    !self.author_finished_at.nil?
  end

  def is_testing?
    self.is_testing
  end

  protected

  def game_starts_in_the_future
    if self.author_finished_at.nil? and self.starts_at and self.starts_at < Time.now
      self.errors.add(:starts_at, "Вы выбрали дату из прошлого. Так нельзя :-)")
    end
  end

  def valid_max_num
    if self.max_team_number
      if self.max_team_number < self.requested_teams_number
        self.errors.add(:max_team_number, "Количество команд, подавших заявку превышает заданное число")
      end
    end
  end

  def deadline_is_in_future
    if self.author_finished_at.nil? and self.registration_deadline and self.registration_deadline < Time.now
      self.errors.add(:registration_deadline, "Вы указали крайний срок регистрации из прошлого, так нельзя :-)")
    end
  end

  def deadline_is_before_game_start
    if self.registration_deadline and
            self.starts_at and self.registration_deadline > self.starts_at
      self.errors.add(:registration_deadline, "Вы указали крайний срок регистрации больше даты начала игры, так нельзя :-)")
    end
  end
end

