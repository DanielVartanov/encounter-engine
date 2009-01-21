class Application < Merb::Controller

protected

  def ensure_team_member
    unless current_user.member_of_any_team?
      raise Unauthorized, "Вы не авторизованы для посещения данной страницы"
    end
  end
end