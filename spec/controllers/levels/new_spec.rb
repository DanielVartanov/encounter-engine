require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Levels, "#new" do
  describe "security filters" do
    describe "when the game author attempts to create a new level" do
      before :each do
        @author = create_user
        @game = create_game :author => @author
      end

      it "responds successfully" do
        response = perform_request(:as_user => @author)
        response.should be_successful
      end
    end

    describe "when any other user attempts to create a new level" do
      before :each do
        @user = create_user
        @game = create_game
      end

      it "raises Unauthorized exception" do
        assert_unauthorized { perform_request(:as_user => @user) }
      end
    end

    describe "when a guest attempts to create a new level" do
      before :each do
        @game = create_game :is_draft => false
      end

      it "raises Unauthenticated exception" do
        assert_unauthorized { perform_request }
      end
    end
  end

  def perform_request(opts={}, params={})
    params = params.merge(:game_id => @game.id)
    dispatch_to Levels, :new, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end