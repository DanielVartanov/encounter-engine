class Invitation < ActiveRecord::Base
  belongs_to :from_team, :class_name => "Team"
  belongs_to :to_user, :class_name => "User"

  attr_accessor :recepient_email

  validates_presence_of :to_user, 
    :message => "Пользователя с таким адресом не существует"

  validates_presence_of :recepient_email, 
    :message => "Вы не ввели адрес пользователя"

  validates_uniqueness_of :to_user_id,
    :scope => [:from_team_id],
    :message => "Вы уже высылали этому пользователю приглашение и он ещё не ответил"
  
  validate :recepient_is_not_member_of_any_team

  before_validation :find_user

protected

  def find_user
    self.to_user = User.find_by_email recepient_email
  end

  def recepient_is_not_member_of_any_team
    errors.add_to_base("Пользователь уже является членом одной из команд") if to_user and to_user.member_of_any_team?
  end
end