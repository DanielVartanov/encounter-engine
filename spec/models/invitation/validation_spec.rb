require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Invitation do
  describe "regular case, captain attempts to invite a new user" do
    before :each do
      user = create_user
      captain = create_user
      team = create_team :captain => captain

      @invitation = Invitation.new(:to_team => team, :recepient_nickname => user.nickname)
    end

    it "should be valid" do
      @invitation.should be_valid
    end
  end

  describe "captain attempts to invite a member of another team" do
    before :each do
      captain = create_user
      team = create_team :captain => captain
      user = create_user
      create_team :captain => create_user, :members => [user]

      @invitation = Invitation.new(:to_team => team, :recepient_nickname => user.nickname)
    end

    it "should not be valid" do
      @invitation.should_not be_valid
    end
  end

  describe "captain attempts to invite a member of his own team" do
    before :each do
      captain = create_user
      user = create_user
      team = create_team :captain => captain, :members => [user]

      @invitation = Invitation.new(:to_team => team, :recepient_nickname => user.nickname)
    end

    it "should not be valid" do
      @invitation.should_not be_valid
    end
  end

  describe "captain attempts to invite himself :-)" do
    before :each do
      captain = create_user
      team = create_team :captain => captain

      @invitation = Invitation.new(:to_team => team, :recepient_nickname => captain.email)
    end

    it "should not be valid" do
      @invitation.should_not be_valid
    end
  end

  describe "captain attempts to invite someone twice" do
    before :each do
      captain = create_user
      user = create_user
      team = create_team :captain => captain
      Invitation.create!(:to_team => team, :recepient_nickname => user.nickname)

      @invitation = Invitation.new(:to_team => team, :recepient_nickname => user.nickname)
    end

    it "should not be valid" do
      @invitation.should_not be_valid
    end
  end

  describe "two captains invite same user" do
    before :each do
      captain1 = create_user
      captain2 = create_user
      team1 = create_team :captain => captain1
      team2 = create_team :captain => captain2

      user = create_user
      Invitation.create!(:to_team => team1, :recepient_nickname => user.nickname)

      @invitation = Invitation.new(:to_team => team2, :recepient_nickname => user.nickname)
    end

    it "should be valid" do
      @invitation.should be_valid
    end
  end

  describe "captain attempts to create invitation without providing recipient email" do
    before :each do
      captain = create_user
      team = create_team :captain => captain

      @invitation = Invitation.new(:to_team => team, :recepient_nickname => nil)
    end

    it "should not be valid" do
      @invitation.should_not be_valid
    end
  end

  describe "captain attempts providing an unexistant recipient email" do
    before :each do
      captain = create_user
      team = create_team :captain => captain

      @invitation = Invitation.new(:to_team => team, :recepient_nickname => "unexistent@email.com")
    end

    it "should not be valid" do
      @invitation.should_not be_valid
    end
  end
end