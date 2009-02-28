require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Invitations, "#accept" do
  describe "when recepient attempts to accept the invitation" do
    before :each do
      @recepient = create_user
      @invitation = create_invitation :for => @recepient
      create_invitation :for => @recepient

      perform_request :as_user => @recepient
    end

    it "redirects to dashboard"

    it "deletes all the invitations sent to user" do
      Invitation.for(@recepient).count.should == 0
    end

    it "makes invited user member of the team" do
      @recepient.reload
      @recepient.team.should_not be_nil
      @recepient.team.id.should == @invitation.to_team.id
    end
  end

  describe "when captain (sender) attempts to accept the invitation" do
    before :each do
      @captain = create_user
      team = create_team :captain => @captain
      @invitation = create_invitation :for => create_user, :from => team
    end

    it "raises Unauthorized" do
      assert_unauthorized { perform_request :as_user => @captain }
    end

    it "does not delete any invitation" do
      assert_does_not_delete_invitation { perform_rescued_request :as_user => @captain }
    end
  end

  describe "when other logged in user attempts to accept the invitation" do
    before :each do
      @some_user = create_user
      @invitation = create_invitation
    end

    it "raises Unauthorized" do
      assert_unauthorized { perform_request :as_user => @some_user }
    end

    it "does not delete any invitation" do
      assert_does_not_delete_invitation { perform_rescued_request :as_user => @some_user }
    end
  end

  describe "when guest attempts to accept the invitation" do
    before :each do
      @invitation = create_invitation
    end

    it "raises Unauthenticated" do
      assert_unauthenticated { perform_request }
    end

    it "does not delete any invitation" do
      assert_does_not_delete_invitation { perform_rescued_request }
    end
  end

  def assert_does_not_delete_invitation(&block)
    block.should_not change(Invitation, :count)
  end

  def perform_rescued_request(opts={})
    begin
      perform_request opts
    rescue
    end
  end

  def perform_request(opts={})
    params = { :id => @invitation.id }
    dispatch_to Invitations, :accept, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end