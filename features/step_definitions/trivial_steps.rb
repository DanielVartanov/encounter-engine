# frozen_string_literal: true

module KnownPages
  KNOWN_PAGES = {
    'SomePage' => -> { some_page_path },
  }.freeze

  def visit_known_page(page_name)
    visit instance_exec(&KNOWN_PAGES.fetch(page_name))
  end
end

World(KnownPages)

Given 'I am on the {string} page' do |page|
  visit_known_page page
end

When 'I go to the {string} page' do |page|
  visit_known_page page
end

When 'I fill in {string} with {string}' do |input_field, value|
  fill_in input_field, with: value
end

When 'I click {string}' do |clickable|
  click_on clickable
end

When 'I open another browser window' do
  Capybara.session_name = 'another browser window'
end

When 'I close another browser window' do
  Capybara.session_name = :default
end

Then 'I should see {string}' do |text|
  expect(page).to have_content text
end

Then 'I should NOT see {string}' do |text|
  expect(page).to have_no_content text
end
