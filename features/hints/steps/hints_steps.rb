# -*- encoding : utf-8 -*-
Given %r(на уровне "(.*)" следующие подсказки:$)i do |level_name, hints_table|
  level = Level.where(name: level_name).first
  author_name = level.game.author.nickname

  hints_table.hashes.each do |hash|
    text = hash['Текст']
    delay = hash['Через'].match(/(\d+) минут.?/)[1]
    Given %{#{author_name} добавила подсказку "#{text}" через #{delay} минут на уровне "#{level_name}"}
  end
end

Given %r((.*) добавила? подсказку "(.*)" через (\d+) минут на уровне "(.*)")i do |author_name, hint_text, hint_delay, level_name|
  Given %{я логинюсь как #{author_name}}
  Given %{захожу в профиль задания "#{level_name}"}
  When %{я иду по ссылке "Добавить подсказку"}
  When %{ввожу "#{hint_text}" в поле "Текст"}
  When %{ввожу "#{hint_delay}" в поле "Через"}
  When %{нажимаю "Добавить"}
  Then %{должен быть перенаправлен в профиль задания "#{level_name}"}
  Then %{должен увидеть "#{hint_text}"}
  Then %{должен увидеть "#{hint_delay}"}
end
