class Teams < Application
  before :ensure_authenticated
  before :ensure_team_member, :exclude => [:new, :create]
  before :ensure_not_member_of_any_team, :only => [:new, :create]
  before :build_team
  before :find_team, :only => [:update, :index, :show, :edit]
  before :ensure_team_captain, :only => [:show, :edit]

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

protected

  def build_team
    @team = Team.new(params[:team])
  end

  def find_team
    @team = Team.find(params[:id])
  end

  def ensure_not_member_of_any_team
    raise Unauthorized, "Вы уже являетесь членом команды" if current_user.member_of_any_team?
  end

  def ensure_team_captain
    @current_user.captain_of_team?(@team)
  end
end