class GameEntries < Application
  before :ensure_authenticated
  before :find_game, :only=>:new
  before :find_team, :only=>:new
  before :find_entry, :exclude =>:new
  before :ensure_author, :only => [:accept, :reject]
  before :ensure_captain, :exclude => [:accept, :reject]

  def new
    @game_entry = GameEntry.new
    @game_entry.status = "new"
    @game_entry.game = @game
    @game_entry.team_id = @team.id
    @game_entry.save
    redirect url(:dashboard)
  end

  def reopen
    if @entry.status != "accepted"
      @entry.status = "new"
      @entry.save
      redirect url(:dashboard)
    else
      redirect url(:dashboard)
    end
  end
  
  def accept
    if @entry.status == "new"
       @entry.status = "accepted"
       @entry.save
       redirect url(:dashboard)
    else
       redirect url(:dashboard)
    end
  end
  
  def reject
    if @entry.status == "new"
       @entry.status = "rejected"
       @entry.save
       redirect url(:dashboard)
    else
       redirect url(:dashboard)
    end
  end

  def recall
    if @entry.status == "new"
       @entry.status = "recalled"
       @entry.save
       redirect url(:dashboard)
    else
       redirect url(:dashboard)
    end
  end

  def cancel
    if @entry.status == "accepted"
      @entry.status = "canceled"
      @entry.save
      redirect url(:dashboard)
    else
      redirect url(:dashboard)
    end
end

protected
  def find_game
    @game = Game.find(params[:game_id])
  end
  
  def find_team
    @team = Team.find(params[:team_id])
  end

  def find_entry
    @entry = GameEntry.find(params[:id])
    if @entry
      @game = Game.find(@entry.game.id)
    end
  end

  def ensure_captain
    if current_user.captain? && @game.created_by?(current_user)
      return true
    else
      return false
    end
  end
end