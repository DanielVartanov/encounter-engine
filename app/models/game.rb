class Game < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  validates_presence_of :name,
    :message => "Вы не ввели название"

  validates_uniqueness_of :name,
    :message => "Игра с таким названием уже существует"

  validates_presence_of :description,
    :message => "Вы не ввели описание"

  validates_presence_of :author
end