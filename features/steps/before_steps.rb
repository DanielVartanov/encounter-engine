Before do
  clear_mail_deliveries
  recreate_database
end

def clear_mail_deliveries
  Merb::Mailer.deliveries.clear
end

include ActiveRecordHelper
def recreate_database
  ActiveRecordHelper::ActiveRecordHelper.recreate_database!
end