class Application < Merb::Controller
  before :find_user_from_session

protected

  def current_user
    session.user
  end

  def find_user_from_session
    @current_user = current_user
  end
end