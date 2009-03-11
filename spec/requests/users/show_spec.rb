require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

given "a user exists" do
  User.create!(:nickname => "valid", :email => "valid@email.com", :password => "1234",
    :password_confirmation => "1234")
end

describe "resource(@user)", :given => "a user exists" do
  describe "GET" do
    before(:each) do
      @response = request(resource(User.first))
    end

    it "responds successfully" do
      @response.should be_successful
    end
  end
end