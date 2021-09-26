def current_team
  current_team_name = page.text.match(/Вы вошли как (.*)/)[1]
  Team.find_by name: current_team_name
end

def sign_in(as:)
  visit '/sessions/new'
  select as.name, from: 'Выберите команду'
  click_on 'Войти'
  sleep 0.1 # That's because for some reason I don't want to dig too
  # deep on, the form does not wait until server does its job setting
  # a session, therefore we wait. This form is temporary anyway.
end

Если '(я )логинюсь как {string}' do |team_name|
  team = Team.find_by(name: team_name)
  sign_in as: team
end
