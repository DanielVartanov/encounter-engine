def the_game
  @the_game
end

def the_play
  @the_play ||= the_game.plays.first || the_game.plays.create!
end

def level_by_name(level_name)
  the_game.levels.find_by name: level_name
end

Допустим 'игру {string} со следующими уровнями:' do |название_игры, уровни|
  @the_game = create(:game, name: название_игры).tap do |игра|
    уровни.hashes.each do |уровень|
      create :level, game: игра, name: уровень['название'], answer: уровень['правильный ответ']
    end
  end
end


Допустим('моя команда сейчас на уровне {string}') do |level_name|
  the_play.update_attribute :current_level, level_by_name(level_name)
end

Допустим('игра началась') do
  # empty for now
end

Допустим('я член играющей команды') do
  # empty for now
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
