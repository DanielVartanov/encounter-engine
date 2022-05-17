# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games do
    resource :play, only: [:show] do
      resources :answer_attempts, only: [:create]
    end

    resource :finish, only: [:show]
  end

  resources :sessions, only: [:new, :create]
end
