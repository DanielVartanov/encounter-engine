require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Game do
  describe "description and name fields" do
    describe "when only whitespaces entered" do
      before :each do
        @game = build_game :name => "   \t", :description => "  \t\n\r"
        @game.valid?
      end

      it "should not be valid" do
        @game.should_not be_valid
        @game.errors.on(:name).should_not be_empty
        @game.errors.on(:description).should_not be_empty
      end
    end
  end

  describe "starts_at field" do
    describe "when valid date and time entered" do
      before :each do
        @game = build_game :starts_at => "2026-01-10 18:30"
        @game.valid?
      end

      it "should be valid" do
        @game.should be_valid
      end
    end

    describe "when invalid/unformatted date and time entered" do
      before :each do
        @game = build_game :starts_at => "сёдня в полшистова"
        @game.valid?
      end

      it "should be valid" do
        @game.should be_valid        
      end

      it "should be nil" do
        @game.starts_at.should be_nil
      end
    end

    describe "when only date entered" do
      before :each do
        @game = build_game :starts_at => "2099-01-01"
        @game.valid?
      end

      it "should be valid" do
        @game.should be_valid
      end

      it "should be midnight" do
        @game.starts_at.to_s.should match(/00:00:00/)
      end
    end

    describe "when date/time in the past entered" do
      before :each do
        @game = build_game :starts_at => "1971-01-01 00:00"
        @game.valid?
      end

      it "should not be valid" do
        @game.should_not be_valid
        @game.errors.on(:starts_at).should_not be_empty
      end
    end
  end
end