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

When /ввожу код "([^\"]*)"$/ do |code|
  When %{я ввожу "#{code}" в поле "Код"}
  When %{нажимаю "Отправить!"}
end

When /ввожу код "([^\"]*)" в игре "([^\"]*)"/ do |code, game_name|
  When %{захожу в игру "#{game_name}"}
  And %{ввожу код "#{code}"}
end

When /команда (.*) вводит правильный код текущего уровня игры "(.*)"/ do |team_name, game_name|
  team = Team.find_by_name(team_name)
  game = Game.find_by_name(game_name)
  current_level = team.current_level_in(game) || game.levels.first

  Given %{я логинюсь как #{team.captain.nickname}}
  When %{ввожу код "#{current_level.questions.first.answers.first.value}" в игре "#{game_name}"}
  Then %{должен увидеть "#{current_level.next.name}"}
end

When /команда (.*) вводит правильный код последнего уровня игры "(.*)"/ do |team_name, game_name|
  team = Team.find_by_name(team_name)
  game = Game.find_by_name(game_name)
  current_level = game.levels.last

  Given %{я логинюсь как #{team.captain.nickname}}
  When %{ввожу код "#{current_level.questions.first.answers.first.value}" в игре "#{game_name}"}
  Then %{должен увидеть "Поздравляем"}
end

When /захожу в игру "([^\"]*)"/ do |game_name|
  game = Game.find_by_name(game_name)

  When %{я захожу в личный кабинет}



  within "#game-#{game.id}" do |scope|
    scope.click_link "Играть!"
  end
end

Then /список победителей должен быть следующим:$/ do |expected_results_table|
  expected_results_table.diff!(tableish('#results tr', 'td,th'), :missing_col => false)
end

Then /должен увидеть следующие позиции команд:$/ do |expected_stats_table|
  expected_stats_table.diff!(tableish('table#stats tr', 'td,th'))
end

When /захожу в статистику игры "(.*)"$/ do |game_name|
  Given %{захожу в личный кабинет}
  Then %{должен увидеть "#{game_name}"}
  Given %{иду по ссылке "(статистика)"}
end

Given /в "(.*)" команда "(.*)" на задании "(.*)" игры "(.*)" ввела код "(.*)"$/ do |datetime, team_name, level_name, game_name, code|
  team = Team.find_by_name(team_name)

  Given %{сейчас "#{datetime}"}
  Given %{я логинюсь как #{team.captain.nickname}}
  Given %{команда #{team_name} находится на уровне "#{level_name}" игры "#{game_name}"}
  And %{ввожу код "#{code}"}
end

Given /^команда (.*) сошла с дистанции игры "([^"]*)"$/ do |team_name, game_name|
  team = Team.find_by_name(team_name)

  Given %{я логинюсь как #{team.captain.nickname}}
  Given %{я захожу в игру "#{game_name}"}
  Given %{ иду по ссылке "Сойти с дистанции"}
end

Then /должен увидеть следующюю таблицу:/ do |strings_table|
  strings_table.diff!(tableish('#results tr', 'td,th'), :missing_col => false)
end

Given /^я обновляю страницу$/ do

end