class Application < Merb::Controller
  def find_user_from_session
    @current_user = session.user
  end
end