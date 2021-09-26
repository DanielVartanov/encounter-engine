def the_team
  @the_team
end

def another_team
  @another_team
end

Допустим 'есть команда {string}' do |team_name|
  create :team, name: team_name
end

Допустим('я член играющей команды') do
  @the_team = create(:team)
  sign_in as: the_team
  visit game_play_path(the_game)
end

Допустим('я член другой играющей команды') do
  @another_team = create(:team)
  sign_in as: another_team
end
