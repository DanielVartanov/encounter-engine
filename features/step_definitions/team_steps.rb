# frozen_string_literal: true

Допустим 'есть команда {string}' do |team_name|
  create :team, name: team_name
end
