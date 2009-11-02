Given %r(в игре "(.*)" следующие задания:$)i do |game_name, levels_table|
  game = Game.find_by_name(game_name)
  author_name = game.author.nickname

  levels_table.hashes.each do |hash|
    level_name = hash['Название']
    correct_answer = hash['Код']
    Допустим %{#{author_name} добавляет задание "#{level_name}"|#{correct_answer} в игру "#{game_name}"}
  end
end

Given /добавляю задание "(.*)" в игру "(.*)"/ do |level_name, game_name|
  Допустим %{добавляю задание "#{level_name}"|enКраблеБумц в игру "#{game_name}"}
end

Given /добавляю задание "(.*)"\|(\S*) в игру "(.*)"/ do |level_name, correct_answer, game_name|
  Допустим %{захожу в профиль игры "#{game_name}"}  
  И %{иду по ссылке "Добавить новое задание"}
  Если %{я ввожу "#{level_name}" в поле "Название"}
  И %{ввожу "#{level_name}" в поле "Текст задания"}
  И %{ввожу "#{correct_answer}" в поле "Правильные ответы"}
  И %{нажимаю "Добавить задание"}
  То %{должен быть перенаправлен в профиль задания "#{level_name}"}
  И %{должен увидеть "#{level_name}"}  
end

Given %r{^(.*) добавляет задание "(.*)" в игру "(.*)"}i do |user_name, level_name, game_name|
  Допустим %{я логинюсь как #{user_name}}
  И %{добавляю задание "#{level_name}" в игру "#{game_name}"}
end

Given %r{^(.*) добавляет задание "(.*)"\|(\S*) в игру "(.*)"$}i do |user_name, level_name, correct_answer, game_name|
  Допустим %{я логинюсь как #{user_name}}
  И %{добавляю задание "#{level_name}"|#{correct_answer} в игру "#{game_name}"}
end

When %r{захожу в профиль задания "(.*)"$}i do |level_name|
  level = Level.find_by_name(level_name)
  То %{захожу по адресу #{resource(level.game, level)}}
end

Then /должен быть перенаправлен в профиль задания "(.*)"/ do |level_name|  
  level = Level.find_by_name(level_name)
  То %{должен быть перенаправлен по адресу #{resource(level.game, level)}}
end
