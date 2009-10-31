require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "#hints_to_show" do
  describe "given a level with hints after 10, 30 and 50 minutes" do
    before :each do
      @game = create_game
      @level_with_hints = create_level :game => @game
      @first_hint = create_hint :delay => 10.minutes, :level => @level_with_hints
      @second_hint = create_hint :delay => 30.minutes, :level => @level_with_hints
      @third_hint = create_hint :delay => 50.minutes, :level => @level_with_hints
    end

    describe "given a team at this level" do
      before :each do
        @team = create_team
        @game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @level_with_hints
      end

      describe "when team just enters the level" do
        it "should return empty array" do
          @game_passing.hints_to_show.should be_empty
        end
      end

      describe "when 10 minutes passed" do
        before :each do
          Time.stub!(:now => @game_passing.current_level_entered_at + 10.minutes)
        end        

        it "should return one first hint" do
          @game_passing.hints_to_show.should == [@first_hint]
        end
      end

      describe "when 30 minutes passed" do
        before :each do
          Time.stub!(:now => @game_passing.current_level_entered_at + 30.minutes)
        end

        it "should return two first hints" do
          @game_passing.hints_to_show.should == [@first_hint, @second_hint]
        end
      end
      
      describe "when 50 minutes passed" do
        before :each do
          Time.stub!(:now => @game_passing.current_level_entered_at + 50.minutes)
        end

        it "should return all three hints" do
          @game_passing.hints_to_show.should == [@first_hint, @second_hint, @third_hint]
        end
      end
    end
  end
end