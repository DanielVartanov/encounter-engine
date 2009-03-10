require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe User, "#nickname" do
  before :each do
    @user = User.new :email => "aldor@diesel.kg"
  end

  describe "when called" do
    before :each do
      @result = @user.nickname
    end

    it "should return capitalized username part of email" do
      @result.should == "Aldor"
    end
  end
end