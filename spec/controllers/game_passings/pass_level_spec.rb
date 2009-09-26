require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "#index" do
  before :each do
    now = Time.now
    Time.stub!(:now => now - 1)
    @game = create_game :starts_at => now

    @correct_answer = "enfirstlevel"
    @first_level = create_level :game => @game, :correct_answers => @correct_answer
    @second_level = create_level :game => @game
    @final_level = create_level :game => @game

    @game.reload
    Time.stub!(:now => now + 1)

    @team_member = create_user
    @team = create_team :captain => @team_member
  end

  after :each do
    Time.rspec_reset
  end

  describe "when a team member enters game passing" do
    describe "with correct answer" do
      before :each do
        @response = perform_request :answer => @correct_answer
      end

      it "should assign false to @result" do
        @response.assigns(:result).should be_true
      end
    end

    describe "with wrong answer" do
      before :each do
        @response = perform_request :answer => 'enblablablabalbla'
      end

      it "should assign false to @result" do
        @response.assigns(:result).should be_false
      end
    end
  end

  def perform_request(opts={})
    dispatch_to GamePassings, :pass_level, { :game_id => @game.id, :answer => opts[:answer] } do |controller|
      controller.session.stub!(:authenticated?).and_return(true)
      controller.session.stub!(:user).and_return(@team_member)
    end
  end
end