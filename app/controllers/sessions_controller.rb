class SessionsController < ApplicationController
  def new = nil

  def create
    session[:team_id] = params.require(:team_id)
    render plain: "You are logged in as #{current_team.name}"
  end
end
