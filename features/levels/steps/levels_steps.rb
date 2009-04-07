Then /должен быть перенаправлен в профиль задания #(\d+) игры "(.*)"/ do |level_order, game_name|
  game = Game.find_by_name(game_name)
  level = game.levels.find_by_order(level_order)
  То %{должен быть перенаправлен по адресу #{resource(game, level)}}
end