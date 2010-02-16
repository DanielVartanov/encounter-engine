require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "answered_quesions" do
  before :each do
    @game_passing = GamePassing.new
  end

  subject { @game_passing.answered_questions }

  it { should be_empty }

  it "should behave like array" do
    question = Question.new
    subject << question
    subject.should == [question]
  end

  context "when it contains some values" do
    before :each do
      @question = Question.create! :answer => 'answer'
      @game_passing.answered_questions << @question
    end

    it "should be persisted correctly" do
      @game_passing.save!
      GamePassing.last.answered_questions.should == [@question]
    end
  end
end