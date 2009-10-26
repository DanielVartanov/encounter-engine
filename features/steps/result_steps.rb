Then /должен увидеть сообщение "(.*)"$/ do |text|
  Then %{должен увидеть "#{text}"}
end

Then /должен увидеть "(.*)"$/ do |text|
  response_body.to_s.should =~ /#{text}/m
end

Then /должен увидеть следующее:/ do |table|
  table.hashes.each do |row|
    То %{должен увидеть "#{row['текст']}"}
  end
end

Then /должен увидеть ссылку на (.*)$/ do |url|
  response_body.to_s.should have_tag("a", :href => url)
end

Then /не должен видеть ссылку на (.*)$/ do |url|
  response_body.to_s.should_not have_tag("a", :href => url)
end

Then /должен увидеть кнопку "(.*)"$/ do |text|
  response_body.to_s.should have_tag("input", :type => "submit", :value => text)
end

Then /должен быть перенаправлен по адресу (.*)/ do |url|
  URI.parse(@response.url).path.should == url
end

Then /не должен видеть "(.*)"$/ do |text|
  response_body.to_s.should_not =~ /#{text}/m
end