# -*- encoding : utf-8 -*-
Given /пользователем (.*) создана игра "(.*)"$/ do |user_name, game_name|
  Given %{я зарегистрирован как #{user_name}}
  Given %{#{user_name} создаёт игру "#{game_name}"}
  #Given %{я разлогиниваюсь}
end

Given /^создана игра "(.*)"$/ do |game_name|
  author_name = 'Author'
  Given %{пользователем #{author_name} создана игра "#{game_name}"}
end

Given /(.*) создаёт игру "(.*)"$/ do |user_name, game_name|
  starts= Time.now + 7.days
  deadline= Time.now + 6.days
  Given %{я логинюсь как #{user_name}}
  When %{я захожу в личный кабинет}
  When %{иду по ссылке "Создать игру"}
  When %{ввожу "#{game_name}" в поле "Название"}
  When %{ввожу "Описание #{game_name}" в поле "Описание"}
  When %{ввожу "2" в поле "Максимальное количество команд"}
  When %{ввожу "#{starts}" в поле "Начало игры"}
  When %{ввожу "#{deadline}" в поле "Крайний срок регистрации"}
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
  Given %{я разлогиниваюсь}
end
Given %r{(.*) назначает крайний срок регистрации на игру "(.*)" на "(.*)"} do |user_name, game_name, datetime|
  Given %{Я логинюсь как #{user_name}}
  When %{захожу в профиль игры "#{game_name}"}
  When %{иду по ссылке "Редактировать эту игру"}
  When %{ввожу "#{datetime}" в поле "Крайний срок регистрации"}
  When %{нажимаю "Сохранить"}
  Then %{должен быть перенаправлен в профиль игры "#{game_name}"}
  Then %{должен увидеть "#{datetime}"}
  Given %{я разлогиниваюсь}
end

Given /начало игры "(.*)" назначено на "(.*)"/ do |game_name, datetime|
  game = Game.where(name: game_name).first
  author_name = game.author.nickname
  Given %{#{author_name} назначает начало игры "#{game_name}" на "#{datetime}"}
end
Given /крайний срок регистрации игры "(.*)" назначено на "(.*)"/ do |game_name, datetime|
  game = Game.where(name: game_name).first
  author_name = game.author.nickname
  Given %{#{author_name} назначает крайний срок регистрации на игру "#{game_name}" на "#{datetime}"}
end

When %r{захожу в профиль игры "(.*)"$}i do |game_name|
  game = Game.where(name: game_name).first
  Then %{захожу по адресу #{resource(game)}}
end

When /захожу в список игр$/ do
  When %{я захожу на главную страницу}
  When %{иду по ссылке "Список игр"}
end

Then %r{должен быть перенаправлен в профиль игры "(.*)"$}i do |game_name|
  game = Game.where(name: game_name).first
  Then %{должен быть перенаправлен по адресу #{resource(game)}}
end

Given /^(.*) добавил задание "([^\"]*)" в игру "([^\"]*)"$/ do |author_name, level_name, game_name|
  game = Game.where(name: game_name).first
  Given %{я логинюсь как #{author_name}}
  Given %{добавляю задание "#{level_name}" в игру "#{game_name}"}
end

Given /^в игре "([^\"]*)" нет заданий$/ do |game_name|
  # Это пустышка. Нужна чтобы сценарий читался логично.
end

Given /^игра "([^\"]*)" не черновик$/ do |game_name|
  game = Game.where(name: game_name).first
  author_name = game.author.nickname
  Given %{я логинюсь как #{author_name}}
  When %{захожу в профиль игры "#{game_name}"}
  When %{иду по ссылке "Редактировать эту игру"}
  When %{снимаю галочку "Черновик"}
  When %{нажимаю "Сохранить"}
  Then %{не должен видеть "Черновик"}
end

Given /^игра "([^\"]*)" черновик$/ do |game_name|
  game = Game.where(name: game_name).first
  author_name = game.author.nickname
  Given %{я логинюсь как #{author_name}}
  Given %{захожу в профиль игры "#{game_name}"}
  Given %{иду по ссылке "Редактировать эту игру"}
  Given %{отмечаю галочку "Черновик"}
  Given %{нажимаю "Сохранить"}
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
  game=Game.where(name: game_name).first
  game.starts_at=Time.now+3.days
  game.registration_deadline = Time.now+2.days
  game.save
end

Given /^игра "([^\"]*)" уже начата$/ do |game_name|
  game=Game.where(name: game_name).first
  Given %{сейчас "#{game.starts_at+1.hour}"}

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

Given /^капитан "([^\"]*)" зарегистрировал свою команду на участие в игре "([^\"]*)"$/ do |team_leader, game_name|
  game = Game.where(name: game_name).first
  author_name = game.author.nickname
  Given %{капитан #{team_leader} подал заявку на участие в игре}
  Given %{я разлогиниваюсь}
  Given %{я логинюсь как #{author_name}}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "(принять)"}
  Given %{я разлогиниваюсь}
end

Given /^капитан "([^\"]*)" не зарегистрировал свою команду на участие в игре "([^\"]*)"$/ do |team_leader, game_name|
  game = Game.where(name: game_name).first
  author_name = game.author.nickname
  Given %{капитан #{team_leader} подал заявку на участие в игре}
  Given %{я разлогиниваюсь}
  Given %{я логинюсь как #{author_name}}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "(отказать)"}
  Given %{я разлогиниваюсь}
end

Given /^автор "([^\"]*)" отказал команде на участие в игре$/ do |author_name|
  Given %{я логинюсь как #{author_name}}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "(отказать)"}
  Given %{я разлогиниваюсь}
end

Given /^капитан (.*) подал заявку на участие в игре$/ do |team_leader|
  Given %{я логинюсь как #{team_leader}}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "Подать заявку на регистрацию"}
end

Given /^команда ([^\s]+) подала заявку на участие в игре "(.*)"$/ do |team_name, game_name|
  Given %{зарегистрирована команда "#{team_name}" под руководством team-leader}
  Given %{я логинюсь как team-leader}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "Подать заявку на регистрацию"}
end

Given /^есть задание "([^\"]*)" в игре "([^\"]*)"$/ do |level_name, game_name|
  game = Game.where(name: game_name).first
  author_name = game.author.nickname
  Given %{#{author_name} добавляет задание "#{level_name}" в игру "#{game_name}"}
end

Given /^команда "(.*)" под руководством "(.*)" подала заявку на участие в игре "(.*)"$/ do |team_name, captain_name, game_name|
  Given %{я логинюсь как #{captain_name}}
  When %{я захожу в комнату команды}
  Given %{иду по ссылке "Подать заявку на регистрацию"}
end
Given /^(.*) подтвердил участие команды "(.*)" в игре "(.*)"$/ do |author_name, team_name, game_name|
  Given %{я залогинился как автор игры "#{game_name}"}
  When %{захожу в личный кабинет}
  Given %{иду по ссылке "(принять)"}
end

Given /^я залогинился как автор игры "(.*)"$/ do |game_name|
  game = Game.where(name: game_name).first
  author = User.find(game.author_id)
  Given %{я логинюсь как #{author.nickname}}
end

Given /^команда "([^\"]*)" отозвала заявку на участие в игре$/ do |team_name|
  team = Team.where(name: team_name).first
  captain_name = team.captain.nickname
  Given %{я логинюсь как #{captain_name}}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "Отозвать"}
end
Given /([^\s]+) создал игру "([^\"]*)" с началом в "([^\"]*)" и с крайним сроком регистрации в "([^\"]*)"$/ do |author_name, game_name, starts_at, deadline_at|
  Given %{я зарегистрирован как #{author_name}}
  When %{я захожу в личный кабинет}
  When %{иду по ссылке "Создать игру"}
  When %{ввожу "#{game_name}" в поле "Название"}
  When %{ввожу "Описание #{game_name}" в поле "Описание"}
  When %{ввожу "#{starts_at}" в поле "Начало игры"}
  When %{ввожу "#{deadline_at}" в поле "Крайний срок регистрации"}
  When %{ввожу "6" в поле "Максимальное количество команд"}
  When %{нажимаю "Создать"}
  Then %{должен быть перенаправлен в профиль игры "#{game_name}"}
end

Given /^команда "([^\"]*)" отменила регистрацию в игре$/ do |team_name|
  team = Team.where(name: team_name).first
  captain_name = team.captain.nickname
  Given %{я логинюсь как #{captain_name}}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "Отменить"}
end

Given /^задано максимальное количество команд "([^\"]*)" для игры "([^\"]*)"$/ do |max_num, game_name|
  Given %{я залогинился как автор игры "#{game_name}"}
  Given %{захожу в профиль игры "#{game_name}"}
  Given %{иду по ссылке "Редактировать эту игру"}
  Given %{ввожу "#{max_num}" в поле "Максимальное количество команд"}
  Given %{нажимаю "Сохранить"}
end

When /поле "(.*)" имеет тип "(.*)"$/ do |field, type|
  field_labeled(field).class.to_s.should match(/#{type}/i)
end

Given /^игра завершена автором "(.*)"$/ do |author_name|
  Given %{я логинюсь как #{author_name}}
  Given %{захожу в личный кабинет}
  Given %{иду по ссылке "ЗАВЕРШИТЬ ИГРУ"}
  Given %{я разлогиниваюсь}
end

Then /должен в блоке "([^"]+)" увидеть "([^"]+)"$/ do |block_id, text|
  webrat_session.response.body.should have_selector("##{block_id}") do |content|
    content.should contain(text)
  end
end

Then /не должен в блоке "([^"]+)" видеть "([^"]+)"$/ do |block_id, text|
  webrat_session.response.body.should have_selector("##{block_id}") do |content|
    content.should_not contain(text)
  end
end

Given %r{зарегистрирован определенный пользователь: "([^"]+)", "([^"]+)", "([^"]+)"$}i do |nickname, e_mail, password|
  When %{я пытаюсь зарегистрироваться с данными "#{nickname}", "#{e_mail}", "#{password}"}
  Then %{То я должен быть перенаправлен в личный кабинет}
  Then %{должен увидеть "#{nickname}"}
  Given %{я разлогиниваюсь}
  Given %{все отосланные к этому моменту письма прочитаны}
end

When %r{пытаюсь зарегистрироваться с данными "([^"]+)", "([^"]+)", "([^"]+)"}i do |nickname, e_mail, password|
  Given %{я захожу по адресу /signup}
  When %{я ввожу "#{nickname}" в поле "Имя"}
  When %{ввожу "#{e_mail}" в поле "Email"}
  When %{ввожу "#{password}" в поле "Пароль"}
  When %{ввожу "#{password}" в поле "Подтверждение"}
  When %{нажимаю "Зарегистрироваться"}
end

Then /^данные пользователя "([^"]+)" с паролем "([^"]+)" такие "([^"]+)", "([^"]+)", "([^"]+)"$/ do |nickname, password, date_of_birth, icq_number, jabber_id|
  When %{залогинился как "#{nickname}" с паролем "#{password}"}
  When %{иду по ссылке "Профиль"}
  When %{иду по ссылке "Редактировать профиль..."}
  When %{ввожу "#{date_of_birth}" в поле "Дата рождения"}
  When %{ввожу "#{icq_number}" в поле "Номер ICQ"}
  When %{ввожу "#{jabber_id}" в поле "Jabber ID"}
  When %{нажимаю "Принять изменения"}
  When %{иду по ссылке "Выйти"}
end

Then /^данные капитана "([^"]+)" с паролем "([^"]+)" такие "([^"]+)", "([^"]+)", "([^"]+)", "([^"]+)"$/ do |nickname, password, date_of_birth, icq_number, jabber_id, phone_number|
  When %{залогинился как "#{nickname}" с паролем "#{password}"}
  When %{иду по ссылке "Профиль"}
  When %{иду по ссылке "Редактировать профиль..."}
  When %{ввожу "#{date_of_birth}" в поле "Дата рождения"}
  When %{ввожу "#{icq_number}" в поле "Номер ICQ"}
  When %{ввожу "#{jabber_id}" в поле "Jabber ID"}
  When %{ввожу "#{phone_number}" в поле "Контактный телефон"}
  When %{нажимаю "Принять изменения"}
  When %{иду по ссылке "Выйти"}
end


When %r{залогинился как "([^"]+)" с паролем "([^"]+)"$} do |nickname, password|
  email = User.where(nickname: nickname).first.email

  When %{я захожу по адресу /login}
  When %{ввожу "#{email}" в поле "Email"}
  When %{ввожу "#{password}" в поле "Пароль"}
  When %{нажимаю "Войти"}
  Then %{должен быть перенаправлен в личный кабинет}
  Then %{должен увидеть "#{nickname}"}
end

Given %r{игрок "([^"]+)" с паролем "([^"]+)" создает команду "([^"]+)"}i do |nickname, password, team_name|
  Given %{залогинился как "#{nickname}" с паролем "#{password}"}
  When %{я пытаюсь создать команду "#{team_name}"}
  Then %{должен быть перенаправлен в личный кабинет}
  Then %{там должен увидеть "Вы - капитан команды"}
  Then %{должен увидеть "#{team_name}"}
end

When /^пароль пользователя "([^"]*)" равен "([^"]*)"$/ do |nickname, password|
  Given %{залогинился как "#{nickname}" с паролем "#{password}"}
end

When /^команда "([^\"]*)" завершает игру "([^\"]*)"$/ do |team_name, game_name|
  last_level = Game.where(name: game_name).first.levels.last



  Given %{команда #{team_name} находится на уровне "#{last_level.name}" игры "#{game_name}"}
  Given %{команда #{team_name} вводит правильные коды последнего уровня игры "#{game_name}"}
end

When /команда (.*) вводит правильные коды последнего уровня игры "(.*)"/ do |team_name, game_name|
  team = Team.where(name: team_name).first
  game = Game.where(name: game_name).first
  current_level = game.levels.last

  Given %{я логинюсь как #{team.captain.nickname}}
  current_level.questions.each do |question|
    When %{ввожу код "#{question.answers.first.value}" в игре "#{game_name}"}
  end
  Then %{должен увидеть "Поздравляем"}
end

Given %r{(.*) завершил тестирование игры "(.*)"} do |author_name, game_name|
  Given %{я логинюсь как #{author_name}}
  Given %{захожу в личный кабинет}
  Then %{должен увидеть "#{game_name}"}
  Then %{захожу в профиль игры "#{game_name}"}
  Then %{я иду по ссылке "Начать тестирование"}
  Then %{я иду по ссылке "Старт"}
  Then %{я ввожу "1234" в поле "Код"}
  And %{и нажимаю "Отправить!"}
  Then %{я ввожу "1234" в поле "Код"}
  And %{и нажимаю "Отправить!"}
  Then %{я иду по ссылке "Завершить тестирование"}
  Then %{игра "#{game_name}" не черновик}
  Given %{я разлогиниваюсь}
end
