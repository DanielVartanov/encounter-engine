# frozen_string_literal: true

module KnownPages
  KNOWN_PAGES = {
    'Вход' => -> { new_session_path }
  }.freeze

  def visit_known_page(page_name)
    visit instance_exec(&KNOWN_PAGES.fetch(page_name))
  end
end

World(KnownPages)

Given 'I am on the {string} page' do |page|
  visit_known_page page
end

Если '(я )захожу на страницу {string}' do |page|
  visit_known_page page
end

When 'I fill in {string} with {string}' do |input_field, value|
  fill_in input_field, with: value
end

Если '(я )выбираю {string} из списка {string}' do |element, list_name|
  select element, from: list_name
end

Если '(я )нажимаю {string}' do |clickable|
  click_on clickable
end

Если '(я )открываю другое окно' do
  Capybara.session_name = 'another browser window'
end

Если '(я )закрываю другое окно' do
  Capybara.session_name = :default
end

То '(я )должен видеть {string}' do |text|
  expect(page).to have_content text
end

То '(я )не должен видеть {string}' do |text|
  expect(page).to have_no_content text
end
