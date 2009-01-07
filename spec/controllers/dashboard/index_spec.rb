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

    it "should respond successfully" do
      @response.should be_successful
    end
  end
  
  def perform_request(opts={})
    dispatch_to Dashboard, :index do |controller|
      controller.session.stub!(:authenticated?).and_return(opts[:skip_authentication])
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end