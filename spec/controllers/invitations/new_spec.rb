require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Invitations, "#new" do
  describe "security filters" do
    describe "captain attempts to invites a new member" do
      before :each do
        @captain = create_user
        @team = create_team :captain => @captain
        @response = perform_request :as_user => @captain
      end

      it "responds successfully" do
        @response.should be_successful
      end
    end

    describe "a regular team member attepmts to invite a new member" do
      before :each do
        @captain = create_user
        @member = create_user
        @team = create_team :captain => @captain, :members => [@member]
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

  describe "when it receives blank string as 'for_user' parameter" do
    before :each do
      @captain = create_user
      @team = create_team :captain => @captain
      @response = perform_request :as_user => @captain
      @params = { :invitation => { :recepient_nickname => "" } }
    end

    it "does not raise error" do
      lambda do
        perform_request( { :as_user => @captain }, @params)
      end.should_not raise_error
    end
  end

  describe "when it receives a string with email as 'for_user' parameter" do
    before :each do
      @captain = create_user
      @team = create_team :captain => @captain
      @response = perform_request :as_user => @captain
      @params = { :invitation => { :recepient_nickname => "SomeUser" } }
    end

    it "does not raise error" do
      lambda do
        perform_request( { :as_user => @captain }, @params)
      end.should_not raise_error
    end
  end

  def perform_request(opts={}, params={})
    dispatch_to Invitations, :new, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end