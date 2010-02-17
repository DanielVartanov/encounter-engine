require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "#post_answer" do
  before :each do
    now = Time.now
    Time.stub!(:now => now - 1)
    @game = create_game :starts_at => now

    @correct_answer = "enfirstlevel"
    @first_level = create_level :game => @game, :correct_answer => @correct_answer
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
    context "with correct answer" do
      before :each do
        @response = perform_request :answer => @correct_answer
      end

      it "should assign @answer_was_correct to true" do
        @response.assigns(:answer_was_correct).should be_true
      end

      it "should assign @answer to the posted answer" do
        @response.assigns(:answer).should == @correct_answer
      end
    end

    context "with wrong answer" do
      before :each do
        @response = perform_request :answer => 'enblablablabalbla'
      end

      it "should assign @answer_was_correct to false" do
        @response.assigns(:answer_was_correct).should be_false
      end
      
      it "should assign @answer to the posted answer" do
        @response.assigns(:answer).should == 'enblablablabalbla'
      end
    end

    context "with correct but surrounded by spaces answer" do
      before :each do
        @response = perform_request :answer => "   #{@correct_answer}  "
      end

      it "should assign @answer_was_correct to true" do
        @response.assigns(:answer_was_correct).should be_true
      end

      it "should assign @answer to the posted answer" do
        @response.assigns(:answer).should == @correct_answer
      end
    end
  end

  def perform_request(opts={})
    dispatch_to GamePassings, :post_answer, { :game_id => @game.id, :answer => opts[:answer] } do |controller|
      controller.session.stub!(:authenticated?).and_return(true)
      controller.session.stub!(:user).and_return(@team_member)
    end
  end
end