class Dashboard < Application
  before :ensure_authenticated
  before :find_user_from_session

  def index
    render
  end  
end
