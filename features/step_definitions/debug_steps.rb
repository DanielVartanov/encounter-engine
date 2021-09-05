# frozen_string_literal: true

Then 'I wait' do
  sleep 5
end

Then 'I wait for {int} seconds' do |seconds|
  sleep seconds
end

Then 'I run debugger' do
  sleep 0.5
  jard # rubocop:disable Lint/Debugger
end

Then 'I pause until further notice' do
  ask 'Press ENTER to continue...'
end

Then 'save and open screenshot' do
  sleep 0.5
  save_and_open_screenshot # rubocop:disable Lint/Debugger
end
