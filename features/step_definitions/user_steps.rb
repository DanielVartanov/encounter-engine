# frozen_string_literal: true

Допустим('есть игрок {string}') do |user_name|
  create :user, name: user_name
end

Допустим('у команды {string} есть игрок {string}') do |team_name, user_name|
  team = Team.find_by! name: team_name
  create :user, name: user_name, team: team
end
