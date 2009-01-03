require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

given "logged in" do
  User.delete_all
  
  password = "1234"
  user = { :email => "valid@email.com", :password => password,
    :password_confirmation => password }
  
  request(resource(:users), :method => "POST", :params => { :user => user })
end

given "not logged in" do
  request(url(:logout))
end

describe "resource(@user)", :given => "logged in" do  
  before(:each) do
    @response = request(url(:dashboard))
  end

  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@user)", :given => "not logged in" do
  before(:each) do
    @response = request(url(:dashboard))
  end

  it "prohibits access" do
    @response.status.should == 401
  end
end