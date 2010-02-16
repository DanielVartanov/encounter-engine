require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "unanswered_quesions" do
  describe "given a level with three questions" do
    subject do
      @level = create_level

      %w('answer1 answer2 answer3).each do |answer|
        @level.questions.create! :answer => answer
      end

      GamePassing.create! :current_level => @level
    end

    context "when answered_questions is empty" do
      it "should contain all questions of the level" do
        subject.unanswered_questions.should == @level.questions
      end
    end

    context "when answered_questions has some values" do
      before :each do
        subject.answered_questions << @level.questions.first
        subject.answered_questions << @level.questions.second
      end

      it "should contain the rest of questions" do
        subject.unanswered_questions.should == [@level.third]
      end
    end

    context "when answered_questions contains all level questions" do
      it "should be empty" do
        subject.unanswered_questions.should be_empty
      end
    end
  end
end