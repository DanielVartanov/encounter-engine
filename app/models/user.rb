# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :team

  has_many :created_games, :class_name => "Game", :foreign_key => "author_id"

  validates_presence_of :email, :message => "Не введён e-mail"

  validates_uniqueness_of :email,
    :message => "Пользователь с таким адресом уже зарегистрирован"

  validates_presence_of :nickname,
    :message => "Вы не ввели имя"

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

  def author_of?(game)
    game.author.id == self.id
  end
end
