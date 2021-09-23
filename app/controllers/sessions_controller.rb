class SessionsController < ApplicationController
  def new = nil

  def create
    session[:team_id] = params.require(:team_id)
    authenticate
    redirect_to new_session_path
  end
end
