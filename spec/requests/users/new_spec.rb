require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe "resource(:users, :new)" do
  before(:each) do
    @response = request(resource(:users, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end
