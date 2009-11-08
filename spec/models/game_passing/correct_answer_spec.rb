require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing do
  before :each do
    @correct_answer = "answer"
    @level = create_level :correct_answers => @correct_answer
    @game_passing = GamePassing.create! :current_level => @level
  end

  describe "when asnwer equals to correct_answer" do
    it "should return true" do
      @game_passing.correct_answer?(@correct_answer).should be_true
    end
  end

  describe "when asnwer equals to correct_answer but with redundant spaces" do
    it "should return true" do
      @game_passing.correct_answer?( " #{@correct_answer}  ").should be_true
    end
  end

  describe "when asnwer does not equal to correct_answer" do
    it "should return false" do
      @game_passing.correct_answer?("BLAAAABLABLABLA").should be_false
    end
  end
end