class User < ActiveRecord::Base
  belongs_to :team

  has_many :created_games, :class_name => "Game", :foreign_key => "author_id"

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/i,
    :message => "Неправильный формат поля e-mail"

  validates_uniqueness_of :email, 
    :message => "Пользователь с таким адресом уже зарегистрирован"

  validates_presence_of :nickname,
    :message => "Вы не ввели имя"

  validates_format_of :icq_number,
    :with => /^(\d{6,9})?$/,
    :message => "Неверный номер ICQ",
    :on => :update

  validates_format_of :jabber_id,
    :with => /^(([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,}))?$/i,
    :message => "Неверный Jabber ID",
    :on => :update

  validates_format_of :date_of_birth,
    :with => /^(^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$)?$/i,
    :message => "Неверная дата рождения. Используйте формат ГГГГ-ММ-ДД",
    :on => :update

  validates_format_of :phone_number,
    :with => /^(\d+\b.*)?$/i,
    :message => "Неверный номер телефона. Используйте только цифры",
    :on => :update

  validates_uniqueness_of :nickname,
    :message => "Пользователь с таким именем уже зарегистрирован"

  validates_length_of :password, :minimum => 4,
    :message => "Слишком короткий пароль (минимум 4 символа)",
    :if => :password_required?

  validates_confirmation_of :password, 
    :message => "Пароль и его подтверждение не совпадают",
    :if => :password_required?


  def member_of_any_team?
    !! team
  end

  def captain?
    member_of_any_team? && team.captain.id == id
  end

  def captain_of_team?(team)
    team.captain.id == id
  end

  def author_of?(game)
    game.author.id == self.id
  end
end