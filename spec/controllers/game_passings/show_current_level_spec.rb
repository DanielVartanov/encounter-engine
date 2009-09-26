require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "#index" do
  before :each do
    now = Time.now
    Time.stub!(:now => now - 1)
    @started_game = create_game :starts_at => now
    @first_level = create_level :game => @started_game
    create_level :game => @started_game
    @started_game.reload
    Time.stub!(:now => now + 1)

    @team_member = create_user
    @team = create_team :captain => @team_member
  end

  after :each do
    Time.rspec_reset
  end

  describe "when guest tries to enter game passing" do
    it "raises Unauthenticated exception" do
      lambda do
        perform_request :game => @started_game
      end.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe "when not a team member tries to enter game passing" do
    it "raises Unauthorized exception" do
      lambda do
        lonely_user = create_user
        perform_request :as_user => lonely_user, :game => @started_game
      end.should raise_error(Merb::Controller::Unauthorized)
    end
  end

  describe "when a team member tries to enter game which is not started yet" do
    before :each do
      @not_started_game = create_game :starts_at => Time.now + 1000
    end

    it "raises Unauthorized exception" do
      lambda do        
        perform_request :as_user => @team_member, :game => @not_started_game
      end.should raise_error(Merb::Controller::Unauthorized)
    end
  end

  describe "when game author tries to enter game passing" do
    before :each do
      @author = create_user
      create_team :captain => @author
      @started_game.update_attribute(:author, @author)
    end

    it "raises Unauthorized exception" do
      lambda do        
        perform_request :as_user => @author, :game => @started_game
      end.should raise_error(Merb::Controller::Unauthorized)
    end
  end

  describe "when a team member enters game passing" do
    it "responds successfully" do
      @response = perform_request :as_user => @team_member, :game => @started_game
      @response.should be_successful
    end

    it "creates and assigns game passing" do      
      lambda do
        @response = perform_request :as_user => @team_member, :game => @started_game
      end.should change(GamePassing, :count).by(1)      
    end

    it "does not create game passing for any subsequent call" do
      @response = perform_request :as_user => @team_member, :game => @started_game
      initial_game_passing = @response.assigns(:game_passing)

      lambda do
        @response = perform_request :as_user => @team_member, :game => @started_game
      end.should_not change(GamePassing, :count)

      @response.assigns(:game_passing).id.should == initial_game_passing.id
    end

    it "assigns correct data to game passing attribute" do
      @response = perform_request :as_user => @team_member, :game => @started_game

      game_passing = @response.assigns(:game_passing)
      game_passing.game.id.should == @started_game.id
      game_passing.team.id.should == @team.id
      game_passing.current_level.id.should == @first_level.id
    end
  end

  def perform_request(opts={})
    dispatch_to GamePassings, :show_current_level, { :game_id => opts[:game].id } do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end