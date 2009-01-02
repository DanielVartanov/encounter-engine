class Users < Application
  before :ensure_authenticated, :exclude => [:new]

  def show
    @user = User.find_by_id(params[:id])
    raise NotFound unless @user
    display @user
  end

  # GET /users/new
  def new
    only_provides :html
    @user = User.new(params[:user])
    render
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect url(:user, @user)
    else
      render :new
    end
  end
end