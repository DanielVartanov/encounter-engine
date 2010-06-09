When /захожу в прямой эфир игры "(.*)"$/ do |game_name|
  game = Game.find_by_name(game_name)
  Then %{иду по ссылке "Все игры домена"}
  And %{должен увидеть "#{game_name}"}
  And %{должен увидеть "(прямой эфир)"}
  And %{иду по ссылке "(прямой эфир)"}
end

Given /команда "(.*)" на задании "(.*)" игры "(.*)" вводит код "(.*)"$/ do |team_name, level_name, game_name, code|
  team = Team.find_by_name(team_name)

  Given %{я логинюсь как #{team.captain.nickname}}
  Given %{команда #{team_name} находится на уровне "#{level_name}" игры "#{game_name}"}
  And %{ввожу код "#{code}"}
end

Given /захожу в лог ответов команды "(.*)" по игре "(.*)"$/ do |team_name, game_name|
  game_id = Game.find_by_name(game_name).id
  team_id = Team.find_by_name(team_name).id
  
  Given %{захожу по адресу /logs/level/#{game_id}/#{team_id}}
end


