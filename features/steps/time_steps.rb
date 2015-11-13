# -*- encoding : utf-8 -*-
Given %r{сейчас "(.*)"} do |fake_datetime|
  fake_datetime = Time.parse("#{fake_datetime} UTC")
  Time.stub!(:now => fake_datetime)
end

Given /прошла 1 секунда/ do
  Given %{сейчас "#{Time.now + 1}"}
end

Given /прошло (\d+) минут.{0,1}/ do |minutes|
  Given %{сейчас "#{Time.now + minutes.to_i * 60}"}
end
