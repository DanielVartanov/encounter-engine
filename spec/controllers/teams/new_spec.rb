require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Teams, "#new" do
  describe "regular case, fresh user attempts to create a team" do
    before :each do
      User.delete_all
      user = create_user
      @response = perform_request :as_user => user, :skip_authentication => true
    end

    it "responds successfully" do
      @response.should be_successful
    end
  end

  describe "a guest attempts to create a team" do
    it "raises Unauthenticated exception" do
      lambda do
        perform_request
      end.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe "a member/captain of some team attempts to create another team" do
    before :each do
      @user = create_user
      @team = create_team :captain => @user
    end

    it "raises Unauthorized exception" do
      lambda do
        perform_request :as_user => @user, :skip_authentication => true
      end.should raise_error(Exception::Merb::ControllerExceptions::Unauthorized,
        "Вы уже являетесь членом команды")
    end
  end

  def perform_request(opts={})
    dispatch_to Teams, :new do |controller|
      controller.session.stub!(:authenticated?).and_return(opts[:skip_authentication])
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end