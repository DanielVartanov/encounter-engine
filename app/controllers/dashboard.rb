class Dashboard < Application
  before :ensure_authenticated
  before :find_invitations_for_current_user
  before :find_team

  def index
    @games =Game.by(@current_user)
    @game_entries = []
    @teams = []
    @games.each do |game|
      GameEntry.of_game(game).with_status("new").each do |entry|
         @game_entries << entry
      end
      GameEntry.of_game(game).with_status("accepted").each do |entry|
         @teams << entry.team
       end
    end
    render
  end

protected

  def find_invitations_for_current_user
    @invitations = Invitation.for @current_user
  end

  def find_team
    @team = @current_user.team if @current_user.team
  end
end
