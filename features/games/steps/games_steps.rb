When %r{захожу в профиль игры "(.*)"$}i do |game_name|
  game = Game.find_by_name(game_name)
  То %{захожу по адресу #{resource(game)}}
end

Then %r{должен быть перенаправлен в профиль игры "(.*)"$}i do |game_name|
  game = Game.find_by_name(game_name)
  То %{должен быть перенаправлен на #{resource(game)}}
end