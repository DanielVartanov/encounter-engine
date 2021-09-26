def the_game
  @the_game
end

def the_play
  @the_play ||= the_game.plays.find_by team: the_team
end

def another_play
  @another_play ||= the_game.plays.find_by team: another_team
end

def current_game
  the_game # until we have a scenario with another game
end

def current_play
  current_game.plays.find_by team: current_team
end

def current_level
  current_play.current_level
end

def level_by_name(level_name)
  the_game.levels.find_by name: level_name
end

def create_game_with_levels(levels_table)
  @the_game = create(:game).tap do |game|
    levels_table.raw.each do |level|
      create :level, game: game, name: level.first
    end
  end
end

def create_game_with_levels_and_answers(levels_and_answers_table)
  @the_game = create(:game).tap do |game|
    levels_and_answers_table.hashes.each do |уровень|
      create :level, game: game, name: уровень['название'], answer: уровень['ответ']
    end
  end
end

def submit_answer(answer)
  fill_in 'Ответ', with: answer
  click_on 'Отправить'
end

def submit_correct_answer
  submit_answer current_level.answer
end

Допустим 'есть игра со следующими уровнями:' do |levels_table|
  create_game_with_levels(levels_table)
end

Допустим 'есть игра со следующими уровнями и ответами:' do |levels_and_answers_table|
  create_game_with_levels_and_answers(levels_and_answers_table)
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

Если('я захожу в игру') do
  visit game_play_path(the_game)
end

Если('я ввожу ответ {string}') do |answer|
  submit_answer answer
end

Если('я перехожу на следующий уровень') do
  submit_correct_answer
end

Если('я прохожу игру до уровня {string}') do |target_level_name|
  target_level = current_game.levels.find_by name: target_level_name

  submit_correct_answer until current_level == target_level
end

То('моя команда должна быть на уровне {string}') do |level_name|
  level = level_by_name(level_name)

  expect(page).to have_content "Уровень ##{level.number_in_game} #{level.name}"
end
