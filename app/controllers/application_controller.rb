# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate

  def current_team
    @current_team
  end

  def signed_in?
    current_team.present?
  end

  private

  def authenticate
    @current_team = Team.find session[:team_id] if session.key?(:team_id)
  end
end
