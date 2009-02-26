require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Dashboard, "#index" do
  describe "when guest enters the dashboard" do
    it "raises Unauthenticated exception" do
      lambda do
        perform_request
      end.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe "when logged in user enters the dashboard" do
    before :each do
      user = create_user
      @response = perform_request :as_user => user, :skip_authentication => true
    end

    it "responds successfully" do
      @response.should be_successful
    end    
  end

  describe "when invitations exists" do
    before :each do
      user = create_user
                  
      @expected_invitations = []
      @expected_invitations << create_invitation(:for => user)
      @expected_invitations << create_invitation(:for => user)      
      create_invitation :for => create_user

      @response = perform_request :as_user => user, :skip_authentication => true
    end

    it "assigns invitations for the current user" do
      @response.assigns(:invitations).should be_kind_of(Array)
      @response.assigns(:invitations).length.should == @expected_invitations.length
      @response.assigns(:invitations).each do |invitation|
        expected_invitation?(invitation).should be_true
      end
    end

    def expected_invitation?(invitation)
      @expected_invitations.each do |expected_invitaion|
        return true if expected_invitaion.id == invitation.id
      end
      return false
    end
  end
  
  def perform_request(opts={})
    dispatch_to Dashboard, :index do |controller|
      controller.session.stub!(:authenticated?).and_return(opts[:skip_authentication])
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end