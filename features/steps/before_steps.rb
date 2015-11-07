# -*- encoding : utf-8 -*-
Before do
  clear_mail_deliveries
  recreate_database
  set_common_password
end

After do
  Time.rspec_reset
end

def clear_mail_deliveries
  Merb::Mailer.deliveries.clear
end

def recreate_database
  ActiveRecordHelper.recreate_database!
end

def set_common_password
  @the_password = "1234"
end
