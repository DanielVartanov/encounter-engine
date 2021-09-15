# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_team
    Team.find session[:team_id]
  end
end
