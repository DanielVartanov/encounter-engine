require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing do
  before :each do
    @game = create_game
    @first_level = create_level :game => @game, :correct_answers => "enfirst"
    @second_level = create_level :game => @game, :correct_answers => "ensecond"
    @final_level = create_level :game => @game, :correct_answers => "enfinish"
    @team = create_team

    @game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @first_level
  end

  describe "#check_answer!" do
    describe "when current level is any middle or first level" do
      describe "when answer is wrong" do
        before :each do
          @result = @game_passing.check_answer!('enblablablablabla')
        end

        it "should return false" do
          @result.should be_false
        end

        it "should not change current_level" do
          @game_passing.current_level.should == @first_level
        end
      end

      describe "when answer is correct" do
        before :each do
          @result = @game_passing.check_answer!(@first_level.correct_answers)
        end

        it "should return true" do
          @result.should be_true
        end

        it "should set next level as current" do        
          @game_passing.current_level.should == @second_level
        end      
      end
    end

    describe "when current level is the last level" do
      before :each do
        @game_passing.destroy
        @game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @final_level
      end

      describe "when answer is correct" do
        before :each do
          @result = @game_passing.check_answer!(@final_level.correct_answers)
        end

        it "should return true" do
          @result.should be_true
        end

        it "should set current level to nil" do
          @game_passing.current_level.should be_nil
        end
      end
    end
  end
end