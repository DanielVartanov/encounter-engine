class Game < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  validates_presence_of :name,
    :message => "Вы не ввели название"

  validates_presence_of :description,
    :message => "Вы не ввели описание"
end