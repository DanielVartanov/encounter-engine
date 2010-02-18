require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "#unanswered_quesions" do
  describe "given a level with three questions" do
    before :each do
      @level = create_level :correct_answer => 'answer1'

      %w(answer2 answer3).each do |answer|
        @level.questions.create! :answer => answer
      end
    end

    subject { GamePassing.create! :current_level => @level }

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
        subject.unanswered_questions.should == [@level.questions.third]
      end
    end
  end
end