# frozen_string_literal: true

module ApplicationHelper
  def current_team
    @current_team
  end

  def signed_in?
    current_team.present?
  end
end
