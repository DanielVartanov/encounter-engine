require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Team do
  before :each do
    @team = create_team
  end

  describe "#current_level_in" do
    describe "when there are two games with levels" do
      before :each do
        @first_game = create_game
        5.times { create_level :game => @first_game }
        @first_game.reload

        @second_game = create_game
        5.times { create_level :game => @second_game }
        @second_game.reload
      end

      describe "when team has some progress in these gmes" do
        before :each do
          @first_game_current_level = @first_game.levels.second
          @second_game_current_level = @first_game.levels.first
          GamePassing.create! :team => @team, :game => @first_game, :current_level => @first_game_current_level
          GamePassing.create! :team => @team, :game => @second_game, :current_level => @second_game_current_level
        end

        it "should return correct current level of first game" do
          @team.current_level_in(@first_game).should == @first_game_current_level
        end

        it "should return correct current level of second game" do
          @team.current_level_in(@second_game).should == @second_game_current_level
        end
      end

      describe "whem team has no progress in a game" do
        it "should return nil" do
          @team.current_level_in(@first_game).should be_nil
        end
      end
    end
  end
end