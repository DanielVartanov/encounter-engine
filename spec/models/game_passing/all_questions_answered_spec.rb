require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "#all_questions_answered?" do
  context "given a level with several questions" do
    before :each do
      @level = create_level :correct_answer => random_string
      @level.questions.create! :answer => random_string
    end

    subject { GamePassing.new :current_level => @level }

    context "when no questions were answered" do
      it "should return false" do
        subject.all_questions_answered?.should be_false
      end
    end

    context "when some questions are answered" do
      before :each do
        subject.pass_question! @level.questions.first
      end

      it "should return false" do
        subject.all_questions_answered?.should be_false
      end
    end

    context "when all questions are answered" do
      before :each do
        subject.pass_question! @level.questions.first
        subject.pass_question! @level.questions.second
      end

      it "should return false" do
        subject.all_questions_answered?.should be_true
      end
    end
  end
end