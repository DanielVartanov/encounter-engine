require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Level do
  describe "when correct_answers contains leading or trailing spaces" do
    before :each do
      @level = build_level :correct_answers => "   bla bla   "
      @level.save!
    end

    it "should strip redundant spaces" do
      @level.correct_answers.should == "bla bla"
    end
  end
end