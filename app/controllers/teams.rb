class Teams < Application
  before :ensure_authenticated
  #before :ensure_team_member, :exclude => [:new, :create]
  before :ensure_not_member_of_any_team, :only => [:new, :create]

  def new
    only_provides :html
    @team = Team.new(params[:team])
    render
  end

  def create
    @team = Team.new(params[:team])
    @team.captain = @current_user
    if @team.save
      redirect url(:dashboard)
    else
      render :new
    end
  end

protected

  def ensure_not_member_of_any_team
    raise Unauthorized, "Вы уже являетесь членом команды" if current_user.member_of_any_team?
  end

end