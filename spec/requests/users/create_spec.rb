require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe "resource(:users)" do
  describe "regular case" do
    EMAIL = "valid@email.com"
    PASSWORD = "1234"

    before do
      User.delete_all
      clear_mail_deliveries
      @response = perform_request(EMAIL, PASSWORD, PASSWORD)
    end

    it "redirects to resource(:users)" do      
      @response.should redirect_to(url(:dashboard))
    end

    it "creates a user" do
      User.exists?(:email => EMAIL).should be_true
    end

    it "delivers a welcome letter" do
      Merb::Mailer.should have(1).delivery
      last_delivered_mail.to.first.should == EMAIL
      last_delivered_mail.text.should match(/#{EMAIL}/)
      last_delivered_mail.text.should match(/#{PASSWORD}/)
    end
  end

  describe "email already registered" do
    REGISTERED_EMAIL = "valid@email.com"

    before(:each) do
      User.delete_all
      clear_mail_deliveries
      User.create!(:email => REGISTERED_EMAIL, :password => "sekrit",
        :password_confirmation => "sekrit")      
      @response = perform_request(REGISTERED_EMAIL, "1234", "1234")
    end

    it "responds successfully" do
      @response.should be_successful    
    end

    it "does not create another user" do
      User.count.should == 1
    end

    it "shows a error message" do
      @response.body.include?("уже зарегистрирован").should be_true
    end

    it "does not deliver email" do
      Merb::Mailer.deliveries.should be_empty
    end
  end

  describe "password confirmation does not match" do
    before(:each) do
      User.delete_all
      clear_mail_deliveries
      @response = perform_request("valid@email.com", "1234", "oooops")
    end

    it "responds successfully" do
      @response.should be_successful
    end

    it "does not create a user" do
      User.count.should == 0
    end

    it "shows a error message" do
      @response.body.include?("Пароль и его подтверждение не совпадают").should be_true
    end

    it "does not deliver email" do
      Merb::Mailer.deliveries.should be_empty
    end
  end
  
  describe "invalid email" do
    before(:each) do
      User.delete_all
      clear_mail_deliveries
      @response = perform_request("invalid-mail-booooo", "1234", "1234")
    end

    it "responds successfully" do
      @response.should be_successful
    end

    it "does not create a user" do
      User.count.should == 0
    end

    it "shows a error message" do
      @response.body.include?("Неправильный формат").should be_true
    end

    it "does not deliver email" do
      Merb::Mailer.deliveries.should be_empty
    end
  end
end

def perform_request(email, password, password_confirmation)
  user = { :email => email, :password => password,
    :password_confirmation => password_confirmation }
  
  request(resource(:users), :method => "POST", :params => { :user => user })
end