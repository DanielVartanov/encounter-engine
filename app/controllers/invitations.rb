class Invitations < Application
  before :ensure_authenticated
  before :ensure_team_captain

  def create
    user = User.find_by_email(params[:to_user])

    return redirect_with_error("Пользователя с адресом #{params[:to_user]} не существует") unless user
    return redirect_with_error("Пользователь #{user.email} -- уже член команды #{user.team.name}") if user.member_of_any_team?

    invitation = Invitation.find(:first, :conditions => { :from_team_id => @current_user.team, :to_user_id => user })
    return redirect_with_error("Пользователю #{user.email} вы уже высылали приглашение и он ещё не ответил") if invitation

    Invitation.create!(:from_team => @current_user.team, :to_user => user)
    redirect_with_notice("Приглашение пользователю #{user.email} отправлено")
  end

protected

  def redirect_with_error(error_message)
    redirect url(:team_room), :message => { :error => error_message }
  end

  def redirect_with_notice(error_message)
    redirect url(:team_room), :message => { :notice => error_message }
  end
end