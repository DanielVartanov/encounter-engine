class Users < Application
  def show
    @user = User.find_by_id(params[:id])
    raise NotFound unless @user
    display @user
  end
  
  def new
    only_provides :html
    @user = User.new(params[:user])
    render
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session.user = @user
      redirect url(:dashboard)
    else
      render :new
    end
  end
end