require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Exceptions, "#unauthenticated" do
  before(:each) do
    @response = dispatch_to(Exceptions, :unauthenticated, {})
  end

  it "responds successfully" do
    @response.should be_successful
  end
end