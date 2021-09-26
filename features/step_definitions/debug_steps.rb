# frozen_string_literal: true

Then 'I wait' do
  sleep 5
end

Если '(я )жду {int} секунд(у)' do |seconds|
  sleep seconds
end

То '(я )запускаю отладчик' do
  sleep 0.5
  jard # rubocop:disable Lint/Debugger
end

Then '(я )останавливаюсь до особого распоряжения' do
  ask 'Press ENTER to continue...'
end

Then 'save and open screenshot' do
  sleep 0.5
  save_and_open_screenshot # rubocop:disable Lint/Debugger
end
