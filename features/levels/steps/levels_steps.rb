Given %r(в игре "(.*)" следующие задания:$)i do |game_name, levels_table|
  game = Game.find_by_name(game_name)
  author_name = game.author.nickname

  levels_table.hashes.each do |hash|
    level_name = hash['Название']
    correct_answer = hash['Код']
    Given %{#{author_name} добавляет задание "#{level_name}"|#{correct_answer} в игру "#{game_name}"}
  end
end

Given /добавляю задание "([\w\s]+)" в игру "(.*)"$/ do |level_name, game_name|
  Given %{добавляю задание "#{level_name}" с кодом "enКраблеБумц" в игру "#{game_name}"}
end

Given /добавляю задание "([\w\s]+)" с кодом "(\S+)" в игру "(.*)"$/ do |level_name, correct_answer, game_name|
  Given %{захожу в профиль игры "#{game_name}"}  
  Given %{иду по ссылке "Добавить новое задание"}
  When %{я ввожу "#{level_name}" в поле "Название"}
  When %{ввожу "#{level_name}" в поле "Текст задания"}
  When %{ввожу "#{correct_answer}" в поле "Код"}
  When %{нажимаю "Добавить задание"}
  Then %{должен быть перенаправлен в профиль задания "#{level_name}"}
  Then %{должен увидеть "#{level_name}"}
end

Given %r{^(.*) добавляет задание "([\w\s]+)" в игру "(.*)"}i do |user_name, level_name, game_name|
  Given %{я логинюсь как #{user_name}}
  Given %{добавляю задание "#{level_name}" в игру "#{game_name}"}
end

Given %r{^(.*) добавляет задание "([\w\s]+)" c кодом "(\S*)" в игру "(.*)"$}i do |user_name, level_name, correct_answer, game_name|
  Given %{я логинюсь как #{user_name}}
  Given %{добавляю задание "#{level_name}" с кодом "#{correct_answer}" в игру "#{game_name}"}
end

When %r{захожу в профиль задания "(.*)"$}i do |level_name|
  level = Level.find_by_name(level_name)
  Then %{захожу по адресу #{resource(level.game, level)}}
end

Then /должен быть перенаправлен в профиль задания "(.*)"/ do |level_name|  
  level = Level.find_by_name(level_name)
  Then %{должен быть перенаправлен по адресу #{resource(level.game, level)}}
end
