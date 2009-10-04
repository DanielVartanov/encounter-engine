Given %r{сейчас "(.*)"} do |fake_datetime|
  fake_datetime = Time.parse(fake_datetime)
  Time.stub!(:now => fake_datetime)
end

Given /прошла 1 секунда/ do
  Допустим %{сейчас "#{Time.now + 1}"}
end