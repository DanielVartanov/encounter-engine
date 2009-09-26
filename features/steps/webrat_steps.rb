# Commonly used webrat steps
# http://github.com/brynary/webrat

When /захожу по адресу (.*)$/ do |path|
  @response = visit path
end

When /нажимаю "(.*)"$/ do |button|
  @response = click_button(button)
end

When /иду по ссылке "(.*)"$/ do |link|
  @response = click_link(link)
end

When /ввожу "(.*)" в поле "(.*)"$/ do |value, field|
  @response = fill_in(field, :with => value)
end

When /отмечаю галочку "(.*)"$/ do |field|
  @response = check(field)
end

When /^I select "(.*)" from "(.*)"$/ do |value, field|
  @response = select(value, :from => field)
end

When /^I uncheck "(.*)"$/ do |field|
  @response = uncheck(field)
end

When /^I choose "(.*)"$/ do |field|
  @response = choose(field)
end

When /^I attach the file at "(.*)" to "(.*)" $/ do |path, field|
  @response = attach_file(field, path)
end

Then /^show me the page$/ do
  save_and_open_page
end