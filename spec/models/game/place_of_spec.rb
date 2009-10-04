require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Game, '#place_of' do
  before :each do
    @game = create_game
    3.times { create_level :game => @game }
  end

  describe "there are several teams finished the game" do
    before :each do
      @finished_teams = {}
      1.upto(5) do |place|
        team = create_team
        GamePassing.create!(:team => team, :game => @game, :finished_at => Time.now + place)
        @finished_teams[place] = team
      end      
    end

    describe "when there are teams still playing" do
      before :each do
        @playing_team = create_team
        GamePassing.create! :team => @playing_team, :game => @game, :current_level => @game.levels.second
      end

      it "should return correct place of each team" do
        @finished_teams.each do |place, team|
          @game.place_of(team).should == place
        end
      end

      it "should return nil if team didn't finish yet" do
        @game.place_of(@playing_team).should be_nil
      end

      it "should return nil if team didn't even startd yet" do
        @game.place_of(create_team).should be_nil
      end
    end
  end
end