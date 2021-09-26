# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate

  def current_user
    @current_user
  end

  def current_team
    current_user.team
  end

  def signed_in?
    current_user.present?
  end

  private

  def authenticate
    @current_user = User.find session[:user_id] if session.key?(:user_id)
  end
end
