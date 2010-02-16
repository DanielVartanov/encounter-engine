require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing do
  before :each do
    @game = create_game
    @first_level = create_level :game => @game, :correct_answer => "enfirst"
    @second_level = create_level :game => @game, :correct_answer => "ensecond"
    @final_level = create_level :game => @game, :correct_answer => "enfinish"
    @team = create_team
  end

  describe "#finished?" do
    describe "when we are in the middle of the game" do
      before :each do
        @game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @second_level
      end

      it "should return false" do
        @game_passing.should_not be_finished
      end
    end

    describe "when we passed the last level" do
      before :each do
        @game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @final_level
#        @game_passing.check_answer!(@final_level.questions.first.correct_answer)
        @game_passing.pass_level!
      end

      it "should return true" do
        @game_passing.should be_finished
      end
    end
  end
end