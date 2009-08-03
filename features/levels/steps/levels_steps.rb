Then /должен быть перенаправлен в профиль задания "(.*)"/ do |level_name|
  level = Level.find_by_name(level_name)
  То %{должен быть перенаправлен по адресу #{resource(level.game, level)}}
end