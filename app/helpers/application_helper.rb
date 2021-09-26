# frozen_string_literal: true

module ApplicationHelper
  def current_user
    @current_user
  end

  def current_team
    current_user.team
  end

  def signed_in?
    current_user.present?
  end
end
