# frozen_string_literal: true

Допустим 'на уровне {string} есть следующие подсказки:' do |level_name, hints_table|
  level = level_by_name level_name

  hints_table.hashes.each do |подсказка|
    create :hint, level:,
                  text: подсказка['подсказка'],
                  delay_in_minutes: подсказка['через'].to_i
  end
end
