Given %r(на уровне "(.*)" следующие подсказки:$)i do |level_name, hints_table|
  level = Level.find_by_name(level_name)
  author_name = level.game.author.nickname

  hints_table.hashes.each do |hash|
    text = hash['Текст']
    delay = hash['Через'].match(/(\d+) минут.?/)[1]
    Допустим %{#{author_name} добавила подсказку "#{text}" через #{delay} минут на уровне "#{level_name}"}
  end
end

Given %r((.*) добавила? подсказку "(.*)" через (\d+) минут на уровне "(.*)")i do |author_name, hint_text, hint_delay, level_name|
  Допустим %{я логинюсь как #{author_name}}  
  И %{захожу в профиль задания "#{level_name}"}
  Если %{я иду по ссылке "Добавить подсказку"}
  И %{ввожу "#{hint_text}" в поле "Текст"}
  И %{ввожу "#{hint_delay}" в поле "Через"}
  И %{нажимаю "Добавить"}
  То %{должен быть перенаправлен в профиль задания "#{level_name}"}
  И %{должен увидеть "#{hint_text}"}
  И %{должен увидеть "#{hint_delay}"}
end