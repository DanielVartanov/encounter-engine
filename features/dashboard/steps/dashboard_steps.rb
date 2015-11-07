# -*- encoding : utf-8 -*-
When %r{захожу в личный кабинет}i do
  When %{захожу по адресу /dashboard}
end

Then %r{должен быть перенаправлен в личный кабинет$} do
  Then %{должен быть перенаправлен по адресу /dashboard}
end
