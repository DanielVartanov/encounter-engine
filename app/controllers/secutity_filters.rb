class Application < Merb::Controller

protected

  def ensure_team_member
    unless current_user.member_of_any_team?
      raise Unauthorized, "Вы не авторизованы для посещения этой страницы"
    end
  end

  def ensure_team_captain
    unless current_user.captain?
      raise Unauthorized, "Вы должны быть капитаном чтобы выполнить это действие"
    end
  end
end