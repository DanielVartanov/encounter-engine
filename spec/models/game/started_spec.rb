require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Game, '#started?' do
  before :each do
    tomorrow = DateTime.now + 1
    @game = create_game :starts_at => tomorrow
  end

  describe "when game start date is in future" do
    it "returns false" do
      @game.started?.should be_false
    end
  end

  describe "when game start date is in the past" do
    before :each do
      day_after_tomorrow = DateTime.now + 2
      Time.stub! :now => day_after_tomorrow
    end

    it "returns true" do
      @game.started?.should be_true
    end
  end

  describe "when game start date is not set" do
    before :each do
      @game.starts_at = nil
    end

    it "returns false" do
      @game.started?.should be_false
    end
  end
end