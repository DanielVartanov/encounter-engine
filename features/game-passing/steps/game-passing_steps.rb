Given /команда (.*) находится на уровне "(.*)" игры "(.*)"/ do |team_name, level_name, game_name|
  team = Team.find_by_name(team_name)
  game = Game.find_by_name(game_name)

  Given %{я логинюсь как #{team.captain.nickname}}
  Given %{захожу в игру "#{game_name}"}

  current_level = team.current_level_in(game)
  current_position = current_level.nil? ? 1 : current_level.position

  target_level = game.levels.find_by_name(level_name)
  target_position = target_level.position

  level_count_to_pass = target_position - current_position
  level_count_to_pass.times do
    Given %{команда #{team_name} вводит правильный код текущего уровня игры "#{game_name}"}
  end
end

Given /команда (.*) закончила игру "(.*)"/ do |team_name, game_name|
  last_level = Game.find_by_name(game_name).levels.last

  Given %{команда #{team_name} находится на уровне "#{last_level.name}" игры "#{game_name}"}
  Given %{команда #{team_name} вводит правильный код последнего уровня игры "#{game_name}"}
end

When /ввожу код "(.*)" в игре "(.*)"/ do |answer, game_name|
  When %{захожу в игру "#{game_name}"}
  When %{я ввожу "#{answer}" в поле "Ответ"}
  When %{нажимаю "Отправить!"}
end

When /команда (.*) вводит правильный код текущего уровня игры "(.*)"/ do |team_name, game_name|
  team = Team.find_by_name(team_name)
  game = Game.find_by_name(game_name)
  current_level = team.current_level_in(game) || game.levels.first

  Given %{я логинюсь как #{team.captain.nickname}}
  When %{ввожу код "#{current_level.correct_answers}" в игре "#{game_name}"}
  Then %{должен увидеть "#{current_level.next.name}"}
end

When /команда (.*) вводит правильный код последнего уровня игры "(.*)"/ do |team_name, game_name|
  team = Team.find_by_name(team_name)
  game = Game.find_by_name(game_name)
  current_level = game.levels.last

  Given %{я логинюсь как #{team.captain.nickname}}
  When %{ввожу код "#{current_level.correct_answers}" в игре "#{game_name}"}
  Then %{должен увидеть "Поздравляем"}
end

When /захожу в игру "Котлованы Бишкека"/ do
  When %{я захожу в личный кабинет}
  When %{иду по ссылке "Играть!"}
end

Then /список победителей должен быть следующим:$/ do |expected_results_table|
  expected_results_table.diff!(table_at('#results').to_table, :missing_col => false)
end

Then /должен увидеть следующие позиции команд:$/ do |expected_stats_table|
  expected_stats_table.diff!(table_at('#stats')).to_table
end