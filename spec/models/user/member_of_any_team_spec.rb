require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe User, "#member_of_any_team" do
  describe "when member of any team" do
    before :each do
      @user = create_user
      captain = create_user
      team = create_team :captain => captain
      team.members << @user
      team.save
    end

    it "returns true" do
      @user.member_of_any_team?.should be_true
    end
  end

  describe "when captain of any team" do
    before :each do
      @user = create_user
      create_team :captain => @user
    end

    it "returns true" do
      @user.member_of_any_team?.should be_true
    end
  end

  describe "when not member of any team" do
    before :each do
      @user = create_user
    end

    it "returns false" do
      @user.member_of_any_team?.should be_false
    end
  end
end