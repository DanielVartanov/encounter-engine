When %r{высылаю пользователю (.*) приглашение вступить в команду}i do |recepient_name|
  When %{я захожу в комнату команды}
  When %{иду по ссылке "Пригласить участников"}
  When %{ввожу "#{recepient_name}" в поле "Пригласить нового участника"}
  When %{нажимаю "Пригласить"}
  Then %{должен увидеть "Пользователю #{recepient_name} выслано приглашение"}
end

Then %r{пользователь (.*) должен получить приглашение от команды (.*)}i do |nickname, team_name|
  user_email = User.find_by_nickname(nickname).email

  Given %{я логинюсь как #{nickname}}
  When %{я захожу в личный кабинет}
  Then %{должен увидеть "Вас пригласили в команду #{team_name}"}
  Then %{одно письмо с текстом "Вас пригласили вступить в команду #{team_name}" должно быть выслано на #{user_email}}
end

Then %r{пользователь (.*) не должен получить приглашение}i do |nickname|
  user_email = User.find_by_nickname(nickname).email

  Given %{я логинюсь как #{nickname}}
  When %{я захожу в личный кабинет}
  Then %{я не должен видеть "Вас пригласили в команду"}
  Then %{никакие письма не должны быть высланы на #{user_email} }
end

When %r{как пользователь (.*) принимаю приглашение команды (.*)$}i do |nickname, team_name|
  When %{я захожу в личный кабинет}
  Then %{должен увидеть "Вас пригласили в команду #{team_name}"}

  user = User.find_by_nickname(nickname)
  team = Team.find_by_name(team_name)
  invitation = Invitation.for_user(user).to_team(team).first
  When %{я иду по ссылке "accept-invitation-#{invitation.id}"}
  Then %{должен быть перенаправлен в личный кабинет}
end

When %r{как пользователь (.*) отказываюсь от приглашения команды (.*)$}i do |nickname, team_name|
  When %{я захожу в личный кабинет}
  Then %{должен увидеть "Вас пригласили в команду #{team_name}"}

  user = User.find_by_nickname(nickname)
  team = Team.find_by_name(team_name)
  invitation = Invitation.for_user(user).to_team(team).first  

  When %{я иду по ссылке "reject-invitation-#{invitation.id}"}
  Then %{должен быть перенаправлен в личный кабинет}
end