require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Games, "#new" do
  describe "security filters" do
    describe "registered user attempts to create a game" do
      before :each do
        @user = create_user
        @response = perform_request :as_user => @captain
      end

      it "responds successfully" do
        @response.should be_successful
      end
    end

    describe "a guest attempts to create game" do
      it "raises Unauthenticated exception" do
        assert_unauthenticated { perform_request }
      end
    end
  end
  
  def perform_request(opts={}, params={})
    dispatch_to Games, :new, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end