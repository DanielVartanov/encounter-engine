require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Team do
  describe "when assigning a team member as a captain" do
    before :each do
      @user = create_user
      @team = create_team
      @team.members << @user

      @team.captain = @user
      @team.save
    end

    it "sets user as captain" do
      @team.captain.should == @user
    end
  end

  describe "when assigning an 'external' user as a captain" do
    before :each do
      @user = create_user
      @team = create_team
      
      @team.captain = @user
      @team.save
    end

    it "sets user as captain" do
      @team.captain.should == @user
    end

    it "adds captain to members list" do
      @team.members.should include(@user)
    end
  end
end