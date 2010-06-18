Given /пользователем (.*) создана игра "(.*)"$/ do |user_name, game_name|
  Given %{я зарегистрирован как #{user_name}}
  Given %{#{user_name} создаёт игру "#{game_name}"}
end

Given /^создана игра "(.*)"$/ do |game_name|
  author_name = 'Author'
  Given %{пользователем #{author_name} создана игра "#{game_name}"}
end

Given /(.*) создаёт игру "(.*)"$/ do |user_name, game_name|
  Given %{я логинюсь как #{user_name}}
  When %{я захожу в личный кабинет}
  When %{иду по ссылке "Создать игру"}
  When %{ввожу "#{game_name}" в поле "Название"}
  When %{ввожу "Описание #{game_name}" в поле "Описание"}
  When %{нажимаю "Создать"}
  Then %{должен быть перенаправлен в профиль игры "#{game_name}"}
end

Given %r{(.*) назначает начало игры "(.*)" на "(.*)"} do |user_name, game_name, datetime|
  Given %{Я логинюсь как #{user_name}}
  When %{захожу в профиль игры "#{game_name}"}
  When %{иду по ссылке "Редактировать эту игру"}
  When %{ввожу "#{datetime}" в поле "Начало игры"}
  When %{нажимаю "Сохранить"}
  Then %{должен быть перенаправлен в профиль игры "#{game_name}"}  
  Then %{должен увидеть "#{datetime}"}
end

Given /начало игры "(.*)" назначено на "(.*)"/ do |game_name, datetime|
  game = Game.find_by_name(game_name)
  author_name = game.author.nickname
  Given %{#{author_name} назначает начало игры "#{game_name}" на "#{datetime}"}
end

When %r{захожу в профиль игры "(.*)"$}i do |game_name|  
  game = Game.find_by_name(game_name)  
  Then %{захожу по адресу #{resource(game)}}
end

When /захожу в список игр$/ do
  When %{я захожу на главную страницу}
  When %{иду по ссылке "Список игр"}
end

Then %r{должен быть перенаправлен в профиль игры "(.*)"$}i do |game_name|
  game = Game.find_by_name(game_name)
  Then %{должен быть перенаправлен по адресу #{resource(game)}}
end

Given /^(.*) добавил задание "([^\"]*)" в игру "([^\"]*)"$/ do |author_name, level_name, game_name|
  game = Game.find_by_name(game_name)

  Given %{я логинюсь как #{author_name}}
  Given %{добавляю задание "#{level_name}" в игру "#{game_name}"}
end

Given /^в игре "([^\"]*)" нет заданий$/ do |game_name|
  # Это пустышка. Нужна чтобы сценарий читался логично.
end

Given /^игра "([^\"]*)" не черновик$/ do |game_name|
  game = Game.find_by_name(game_name)
  author_name = game.author.nickname
  Given %{я логинюсь как #{author_name}}
  When %{захожу в профиль игры "#{game_name}"}
  Then %{не должен видеть "Черновик"}
end

Given /^есть пользователь "([^\"]*)"$/ do |user_name|
  Given %{я залогинен как #{user_name}}
  Then %{должен увидеть "#{user_name}"}
end

Given /^пользователь "([^\"]*)" создал команду "([^\"]*)"$/ do |user_name, team_name|
  Given %{зарегистрирована команда "#{team_name}" под руководством (#{user_name})}
end

Given /^пользователь "([^\"]*)" является членом команды "([^\"]*)"$/ do |user_name, team_name|
  Given %{пользователь #{user_name} состоит в команде "#{team_name}"}
end

Given /^я залогинён как "([^\"]*)"$/ do |user_name|
  Given %{я логинюсь как #{user_name}}
end

Given /^игра "([^\"]*)" не начата$/ do |game_name|
  time = Time.now

  month = time.month
  if month<9
    month = "0" + month.to_s
  end

  day = time.day
  if day<9
    day = "0" + day.to_s
  end

  hour = time.hour
  if hour<9
    hour = "0" + hour.to_s
  end

  min = time.min
  if min<9
    min = "0" + min.to_s
  end

  Given %{начало игры "#{game_name}" назначено на "#{time.year+1}-#{month}-#{day} #{hour}:#{min}"}
end

Given /^игра "([^\"]*)" уже начата$/ do |game_name|
  Given %{сейчас "2009-01-01 00:00"}
  Given %{начало игры "#{game_name}" назначено на "2009-01-01 02:00"}
end

When /^я нахожусь на странице "([^\"]*)"$/ do |page|
  page = "личный кабинет" if page == "Личный кабинет"
  page = "комнату команды" if page == "Комната команды"
  When %{захожу в #{page}}
end

Given /^не должен видеть ссылку "([^\"]*)"$/ do |link|
  Then %{не должен видеть ссылку на #{link}$}
end

Given /^должен видеть ссылку "([^\"]*)"$/ do |link|
  Then %{должен видеть ссылку на #{link}$}
end

Given /^страница перегружается$/ do
  
end

When /^нажимаю на "([^\"]*)"$/ do |link|
  Then %{нажимаю #{link}$}
end

Given /^команда "([^\"]*)" зарегистрирована на участие в игре "([^\"]*)"$/ do |team_name, game_name|
  pending # express the regexp above with the code you wish you had
end

Given /^команда "([^\"]*)" не зарегистрирована на участие в игре "([^\"]*)"$/ do |team_name, game_name|
  pending # express the regexp above with the code you wish you had
end

