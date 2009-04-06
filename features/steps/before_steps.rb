Before do
  clear_mail_deliveries
  recreate_database
  set_common_password
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