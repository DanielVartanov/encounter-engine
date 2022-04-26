# frozen_string_literal: true

def the_game
  @the_game
end

def level_by_name(level_name)
  the_game.levels.find_by! name: level_name
end

def create_game_with_levels(levels_table)
  @the_game = create(:game).tap do |game|
    levels_table.raw.each do |level|
      create :level, game:, name: level.first
    end
  end
end

def create_game_with_levels_and_answers(levels_and_answers_table)
  @the_game = create(:game).tap do |game|
    levels_and_answers_table.hashes.each do |уровень|
      create :level, game:, name: уровень['название'], answer: уровень['ответ']
    end
  end
end

Допустим 'есть игра со следующими уровнями:' do |levels_table|
  create_game_with_levels(levels_table)
end

Допустим 'есть игра со следующими уровнями и ответами:' do |levels_and_answers_table|
  create_game_with_levels_and_answers(levels_and_answers_table)
end
