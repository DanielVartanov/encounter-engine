class User < ActiveRecord::Base

  validates_uniqueness_of :email, 
    :message => "Пользователь с таким адресом уже зарегистрирован"

  validates_length_of :password, :minimum => 4,
    :message => "Слишком короткий пароль (минимум 4 символа)",
    :if => :password_required?

  validates_confirmation_of :password, 
    :message => "Пароль и его подтверждение не совпадают",
    :if => :password_required?

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/i, 
    :message => "Неправильный формат поля e-mail"

end
