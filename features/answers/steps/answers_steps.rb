# -*- encoding : utf-8 -*-
Given /^я должен быть перенаправлен на страницу редактирования кода "([^\"]*)"$/ do |code|
  # do nothing
end

Given /^добавляю вариант "([^\"]*)" для кода "([^\"]*)"$/ do |variant, code|
  Given %{захожу на страницу редактирования кода "#{code}"}
  Given %{ввожу "#{variant}" в поле "Ещё один вариант кода"}
  Given %{нажимаю "Добавить вариант кода"}
end

Given /^нажимаю на "([^\"]*)" возле варианта "([^\"]*)"$/ do |button_name, code|
  answer = Answer.where(value: code).first
  within "#answer-#{answer.id}" do |scope|
    scope.click_link button_name
  end
end

Given /^захожу на страницу редактирования кода "([^\"]*)"$/ do |code|
  answer = Answer.where(value: code).first

  Given %{я захожу в профиль задания "#{answer.level.name}"}
  within "#question-#{answer.question.id}" do |scope|
    scope.click_link "(редактировать)"
  end
end

Given /^для уровня "([^\"]*)" есть следующие коды:$/ do |level_name, codes|
  Given %{я захожу в профиль задания "#{level_name}"}

  codes.hashes.each do |hash|
    code = Answer.where(value: hash['Вариант_1']).first
    if code
      Given %{добавляю вариант "#{hash['Вариант_2']}" для кода "#{hash['Вариант_1']}"}
    else
      Given %{добавляю код "#{hash['Вариант_1']}" в задание "#{level_name}"}
      Given %{добавляю вариант "#{hash['Вариант_2']}" для кода "#{hash['Вариант_1']}"}
    end
  end
end
