class Dashboard < Application
  before :ensure_authenticated  

  def index    
    render
  end  
end
