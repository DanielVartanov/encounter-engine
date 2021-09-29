# frozen_string_literal: true

def current_game
  the_game # until we have a scenario with another game
end

def current_play
  current_game.plays.find_by! team: current_team
end

def current_level
  current_play.current_level
end

def submit_answer(answer)
  fill_in 'Ответ', with: answer
  click_on 'Отправить'
end

def submit_correct_answer
  submit_answer current_level.answer
end

Допустим 'я член (другой )играющей команды' do
  member = create :user, team: create(:team)
  sign_in as: member
  visit game_play_path(the_game)
end

Допустим 'я другой член играющей команды' do
  the_team = the_game.plays.first!.team
  another_member = create :user, team: the_team
  sign_in as: another_member
end

Допустим 'моя команда сейчас на уровне {string}' do |level_name|
  current_play.update current_level: level_by_name(level_name)
end

Если 'я захожу в игру' do
  visit game_play_path(the_game)
end

Если 'я ввожу ответ {string}' do |answer|
  submit_answer answer
end

Если 'я перехожу на следующий уровень' do
  submit_correct_answer
end

Если 'я прохожу игру до уровня {string}' do |target_level_name|
  target_level = current_game.levels.find_by! name: target_level_name

  submit_correct_answer until current_level == target_level
end

То 'моя команда должна быть на уровне {string}' do |level_name|
  level = level_by_name(level_name)

  expect(page).to have_content "Уровень ##{level.number_in_game} #{level.name}"
end
