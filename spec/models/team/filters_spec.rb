require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Team do
  describe "when assigning a team member as a captain" do
    before :each do
      @captain = create_user
      @member = create_user
      @team = create_team
      @team.members << [@captain, @member]

      @team.captain = @captain
      @team.save
    end

    it "sets user as captain" do
      @team.captain.should == @captain
    end
  end

  describe "when assigning an 'external' user as a captain" do
    before :each do
      @captain = create_user
      @member = create_user
      @team = create_team
      @team.members << [@member]

      @team.captain = @captain
      @team.save
    end

    it "sets user as captain" do
      @team.captain.should == @captain
    end

    it "adds captain to members list" do
      @team.members.should include(@captain)
    end
  end
end