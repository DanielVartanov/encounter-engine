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
      @params = { :invitation => { :recepient_nickname => @user.nickname } }
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

    it "sends a notification to invited user by email" do
      assert_sends_email { perform_request({ :as_user => @captain }, @params) }

      Merb::Mailer.deliveries.last.to.first.should == @user.email
      Merb::Mailer.deliveries.last.text.should match(/Вас пригласили вступить в команду #{@team.name}/)
    end

    it "assigns captain team as invitation target team" do
      @response = perform_request({ :as_user => @captain }, @params)

      @response.assigns(:invitation).to_team.id.should == @team.id
    end

    it "finds proper user by email" do
      @response = perform_request({ :as_user => @captain }, @params)

      @response.assigns(:invitation).for_user.id.should == @user.id
    end
  end

  def perform_request(opts={}, params={})
    dispatch_to Invitations, :create, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end