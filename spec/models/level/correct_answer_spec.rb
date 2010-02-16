require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Level do
  describe "#correct_answer=" do
    context "when there is no questions yet" do
      before :each do
        @correct_answer = "sekrit"
        subject.correct_answer = @correct_answer
      end

      it "should build a question with a given answer" do
        subject.questions.should have(1).player
        subject.questions.first.answer.should == @correct_answer
      end
    end
  end

  describe "#correct_answer" do
    context "when there is no questions yet" do
      it "should return a blank value" do
        subject.correct_answer.should be_blank
      end
    end

    context "when there is one question" do
      before :each do
        subject.questions.build :answer => "the_answer"
      end

      it "should return its answer" do
        subject.correct_answer.should == "the_answer"
      end
    end
  end
end