# frozen_string_literal: true

def current_team
  current_user.team
end

def current_user
  current_user_name = page.text.match(/Вы вошли как (.*) из команды (.*)/)[1]
  User.find_by! name: current_user_name
end

def sign_in(as:)
  visit '/sessions/new'
  select as.name, from: 'Выберите игрока'
  click_on 'Войти'
  sleep 0.1 # That's because for some reason I don't want to dig too
  # deep on, the form does not wait until server does its job setting
  # a session, therefore we wait. This form is temporary anyway.
end

Если '(я )логинюсь как {string}' do |user_name|
  user = User.find_by! name: user_name
  sign_in as: user
end
