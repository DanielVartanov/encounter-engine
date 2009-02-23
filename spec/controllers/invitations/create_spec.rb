require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Invitations, "#create" do
  describe "security filters" do
    describe "captain attempts to invite a new user" do
      before :each do        
        @captain = create_user
        @team = create_team :captain => @captain        
      end

      it "does not raise any error" do
        lambda do
          perform_request :as_user => @captain
        end.should_not raise_error
      end
    end

    describe "a regular team member attepmts to invite user" do
      before :each do
        captain = create_user
        @member = create_user
        create_team :captain => captain, :members => [@member]
      end

      it "raises Unauthorized exception" do
        assert_unauthorized { perform_request :as_user => @member }
      end
    end

    describe "a guest attempts to create an invitation" do
      it "raises Unauthenticated exception" do
        assert_unauthenticated { perform_request }
      end
    end
  end

  describe "regular case, captain invites a new user" do
    before :each do
      @user = create_user
      @captain = create_user
      @team = create_team :captain => @captain
      @params = { :invitation => { :recepient_email => @user.email } }
    end

    it "redirects with notice" do
      response = perform_request({ :as_user => @captain }, @params)
      response.status.should == 302      
      pending
    end

    it "creates an invitation" do
      lambda do
        perform_request({ :as_user => @captain }, @params)
      end.should change(Invitation, :count).by(1)
    end

    it "finds proper user by email" do
      perform_request({ :as_user => @captain }, @params)
      Invitation.last.id == @user.id      
    end

    it "sends a notification to invited user by email"      
  end

  def perform_request(opts={}, params={})
    dispatch_to Invitations, :create, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end