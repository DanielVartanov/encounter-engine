require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe_mail NotificationMailer, :welcome_letter do
  EMAIL = "e@ma.il"
  PASSWORD = "1234"

  before :each do
    deliver :email => EMAIL, :password => PASSWORD
  end

  it "contains email" do
    @mail.text.should match(/#{EMAIL}/)
  end

  it "contains password" do
    @mail.text.should match(/#{PASSWORD}/)
  end
end