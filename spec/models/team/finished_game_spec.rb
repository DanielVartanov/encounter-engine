require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Team, "#finished?(game)" do
  before :each do
    @team = create_team
    @game = create_game
  end

  describe "when team has finished the game" do
    before :each do
      GamePassing.create! :team => @team, :game => @game, :finished_at => Time.now
    end

    it "should return true" do
      @team.finished?(@game).should be_true
    end
  end

  describe "when team is still playing the game" do
    before :each do
      GamePassing.create! :team => @team, :game => @game, :finished_at => nil
    end

    it "should return false" do
      @team.finished?(@game).should be_false
    end
  end

  describe "when team has not even started the game" do
    it "should return false" do
      @team.finished?(@game).should be_false
    end
  end
end