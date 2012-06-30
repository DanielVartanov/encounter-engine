class Teams < Application
  before :ensure_authenticated
  before :ensure_team_member, :exclude => [:new, :create]
  before :ensure_not_member_of_any_team, :only => [:new, :create]
  before :build_team
  before :find_team, :only => [:update, :index, :show]
  before :ensure_team_captain, :only => [:edit]

  def index
    render :show
  end

  def new
    render
  end

  def create
    
    @team.captain = @current_user
    if @team.save
      redirect url(:dashboard)
    else
      render :new
    end
  end

  def edit
    @team = @current_user.team
    render
  end

  def update
    if params[:team][:name].blank?
      params[:team][:name] = params[:team_old_name]
    end
    if @team.update_attributes(params[:team])
      redirect resource(@team)
    else
      render :edit
    end
  end

  def show
    @team = @current_user.team
    render
  end

  def delete_member
    #raise params.inspect
    who = User.find(params[:member_id])
    if @current_user.captain? && @current_user.team == who.team && !who.captain?
      who.team = nil
      who.save!
      redirect url("teams/edit")
    else
      redirect url(:dashboard)
    end
  end

  def make_member_captain
    who = User.find(params[:member_id])
    if @current_user.captain? && @current_user.team == who.team && !who.captain?
      who_team = @current_user.team
      who_team.captain = who
      who_team.save!
      who.save!
      redirect url("teams")
    else
      redirect url(:dashboard)
    end
  end


protected

  def build_team
    @team = Team.new(params[:team])
  end

  def find_team
    @team = @current_user.team
  end

  def ensure_not_member_of_any_team
    raise Unauthorized, "Вы уже являетесь членом команды" if current_user.member_of_any_team?
  end

end