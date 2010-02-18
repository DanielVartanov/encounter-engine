require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "answered_quesions" do
  subject do
    game_passing = GamePassing.new
    game_passing.answered_questions.clear
    game_passing
  end

  context "after initialization" do
    it "should behave like array" do
      subject.answered_questions.should be_kind_of(Array)
    end

    it "should be empty" do
      subject.answered_questions.should be_empty
    end
  end

  context "when it contains some values" do
    before :each do
      @question = Question.create! :answer => 'answer'
      subject.answered_questions << @question
    end

    it "should be persisted correctly" do      
      subject.save!
      GamePassing.last.answered_questions.should == [@question]
    end
  end
end