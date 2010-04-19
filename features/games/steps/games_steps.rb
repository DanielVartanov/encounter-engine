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