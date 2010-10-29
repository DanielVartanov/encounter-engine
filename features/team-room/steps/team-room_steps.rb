# захожу в комнату команды

When %r{захожу в комнату команды "(.*)"$}i do |team_name|
  team = Team.find_by_name(team_name)
  Then %{захожу по адресу #{resource(team)}}
end
