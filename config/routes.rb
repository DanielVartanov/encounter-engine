# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games do
    get 'play', to: 'plays#play'
  end

  resources :play, only: [] do
    resources :answer_attempts, only: [:create]
  end

  resources :sessions, only: [:new, :create]
end
