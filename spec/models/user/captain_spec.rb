require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe User, '#captain?' do
  describe "when user is captain of some team" do
    before :each do
      @user = create_user
      create_team :captain => @user
    end

    it "returns true" do
      @user.captain?.should be_true
    end
  end

  describe "when user does not belong to any team" do
    before :each do
      @user = create_user
    end

    it "returns false" do
      @user.captain?.should be_false
    end
  end

  describe "when user is a regular member of some team" do
    before :each do
      @user = create_user
      captain = create_user
      team = create_team :captain => captain
      team.members << @user
      team.save
    end

    it "returns false" do
      @user.captain?.should be_false
    end
  end
end
