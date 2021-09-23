def the_game
  @the_game
end

def the_team
  @the_team
end

def another_team
  @another_team
end

def the_play
  @the_play ||= the_game.plays.find_by team: the_team
end

def another_play
  @another_play ||= the_game.plays.find_by team: another_team
end

def level_by_name(level_name)
  the_game.levels.find_by name: level_name
end

def create_game_with_levels(levels_table)
  @the_game = create(:game).tap do |game|
    if levels_table.column_names == ['название', 'правильный ответ']
      levels_table.hashes.each do |уровень|
        create :level, game: game, name: уровень['название'], answer: уровень['правильный ответ']
      end
    else
      levels_table.raw.each do |level|
        create :level, game: game, name: level.first
      end
    end
  end
end

Допустим 'игру со следующими уровнями:' do |levels_table|
  create_game_with_levels(levels_table)
end

Допустим 'есть игра со следующими уровнями:' do |levels_table|
  create_game_with_levels(levels_table)
end

Допустим('моя команда сейчас на уровне {string}') do |level_name|
  the_play.update_attribute :current_level, level_by_name(level_name)
end

Допустим('другая команда сейчас на уровне {string}') do |level_name|
  another_play.update_attribute :current_level, level_by_name(level_name)
end

Допустим('игра началась') do
  # empty for now
end

Допустим('я член играющей команды') do
  @the_team = create(:team)
  sign_in as: the_team
  visit game_play_path(the_game)
end

Допустим('я член другой играющей команды') do
  @another_team = create(:team)
  sign_in as: another_team
end

Если('я захожу в игру') do
  visit game_play_path(the_game)
end

Если('я ввожу ответ {string}') do |answer|
  fill_in 'Ответ', with: answer
  click_on 'Отправить'
end

То('моя команда должна быть на уровне {string}') do |level_name|
  level = level_by_name(level_name)

  expect(page).to have_content "Уровень ##{level.number_in_game} #{level.name}"
end
