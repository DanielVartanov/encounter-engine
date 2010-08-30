class Invitation < ActiveRecord::Base
  belongs_to :to_team, :class_name => "Team"
  belongs_to :for_user, :class_name => "User"
  
  named_scope :for, lambda { |user| { :conditions => { :for_user_id => user.id } } }

  attr_accessor :recepient_nickname

  validates_presence_of :for_user,
    :message => "Пользователя с таким именем не существует"

  validates_presence_of :recepient_nickname,
    :message => "Вы не ввели имени пользователя"

  validates_uniqueness_of :for_user_id,
    :scope => [:to_team_id],
    :message => "Вы уже высылали этому пользователю приглашение и он ещё не ответил"
  
  validate :recepient_is_not_member_of_any_team

  before_validation :find_user
  
  named_scope :for_user, lambda { |user| { :conditions => { :for_user_id => user.id } } }
  named_scope :to_team, lambda { |team| { :conditions => { :to_team_id => team.id } } }
protected

  def find_user
    self.for_user = User.find_by_nickname(recepient_nickname)
  end

  def recepient_is_not_member_of_any_team
    errors.add_to_base("Пользователь уже является членом одной из команд") if for_user and for_user.member_of_any_team?
  end
end