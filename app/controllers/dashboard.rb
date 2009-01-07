class Dashboard < Application
  before :ensure_authenticated  

  def index
    @current_user = current_user
    render
  end  
end
