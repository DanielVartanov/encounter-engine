require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

given "a user exists" do
  User.delete_all
  request(resource(:users), :method => "POST", 
    :params => { :user => { :id => nil }})
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