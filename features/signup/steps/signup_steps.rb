# -*- encoding : utf-8 -*-
Given %r{зарегистрирован пользователь (.*)$}i do |nickname|
  When %{я пытаюсь зарегистрироваться как #{nickname}}
  Then %{То я должен быть перенаправлен в личный кабинет}
  Then %{должен увидеть "#{nickname}"}
  Given %{я разлогиниваюсь}
  Given %{все отосланные к этому моменту письма прочитаны}
end

When %r{пытаюсь зарегистрироваться как (.*)}i do |nickname|
  email = "#{nickname.downcase}@diesel.kg"

  Given %{я захожу по адресу /signup}
  When %{я ввожу "#{nickname}" в поле "Имя"}
  When %{ввожу "#{email}" в поле "Email"}
  When %{ввожу "#{@the_password}" в поле "Пароль"}
  When %{ввожу "#{@the_password}" в поле "Подтверждение"}
  When %{нажимаю "Зарегистрироваться"}
end

Then %r{могу зарегистрироваться как (.*)} do |nickname|
  When %{я пытаюсь зарегистрироваться как #{nickname}}
  Then %{должен быть перенаправлен в личный кабинет}
  Then %{должен увидеть "#{nickname}"}
end
