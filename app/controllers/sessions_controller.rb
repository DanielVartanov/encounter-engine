# frozen_string_literal: true

class SessionsController < ApplicationController
  def new = nil

  def create
    session[:user_id] = params.require(:user_id)
    authenticate
    redirect_to new_session_path
  end
end
