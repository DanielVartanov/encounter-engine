require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Levels, "#move_down" do
  before :each do
    @level = create_level
  end

  describe "security filters" do
    describe "when any other user attempts to move a level down" do
      before :each do
        @user = create_user
      end

      it "raises Unauthorized exception" do
        assert_unauthorized { perform_request(:as_user => @user) }
      end
    end

    describe "when a guest attempts to move a level" do
      it "raises Unauthenticated exception" do
        assert_unauthorized { perform_request }
      end
    end
  end

  describe "when authour moves level down correctly" do
    before :each do
      @author = create_user
      @game = create_game :author => @author
      create_level :game => @game
      @level = create_level :game => @game
      create_level :game => @game
      @initial_level_position = @level.position
      
    end

    it "actually moves level down" do
      lambda do
        perform_request :as_user => @author
      end.should change{ @level.reload.position }.by(1)
    end
  end

  def perform_request(opts={}, params={})
    params = params.merge(:id => @level.id, :game_id => @level.game.id)
    dispatch_to Levels, :move_down, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end