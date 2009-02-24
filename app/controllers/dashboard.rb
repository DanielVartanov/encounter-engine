class Dashboard < Application
  before :ensure_authenticated
  before :find_invitations_for_current_user

  def index    
    render
  end

protected

  def find_invitations_for_current_user
    @invitations = Invitation.for @current_user
  end
end
