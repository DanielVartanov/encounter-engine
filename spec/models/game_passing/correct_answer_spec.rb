require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "correct_answer?" do
	context "when there is one question" do
    subject do
      @correct_answer = random_string
		  @level = create_level :correct_answer => @correct_answer

      GamePassing.create! :current_level => @level
    end

		context "when asnwer equals to correct_answer" do
		  it "should return true" do
		    subject.correct_answer?(@correct_answer).should be_true
		  end
		end

		context "when asnwer equals to correct_answer but with redundant spaces" do
		  it "should return true" do
		    subject.correct_answer?( " #{@correct_answer}  ").should be_true
		  end
		end

		context "when asnwer does not equal to correct_answer" do
		  it "should return false" do
		    subject.correct_answer?("BLAAAABLABLABLA").should be_false
		  end
		end
	end

	context "when there are many questions" do
		subject do
			@level = create_level

			@correct_answers = ['answer1', 'answer2', 'answer3']
			@correct_answers.each do |correct_answer|
				@level.questions.create! :answer => correct_answer
			end

		  GamePassing.create! :current_level => @level
		end

		context "when anwser equals to any of correct answers" do
			it "should return true" do
				subject.correct_answer?(@correct_answers.first).should be_true
			end
		end

		context "when answer equals to correct answer of already answered question" do
			before :each do
				subject.check_answer!(@correct_answers.first)
			end

			it "should return false" do
				subject.correct_answer?(@correct_answers.first).should be_false
			end
		end

		context "when answer does not equal to any of correct answers" do
			it "should return false" do
				subject.correct_answer?('Bla-bla-bla').should be_false
			end
		end

		context "when asnwer equals to correct_answer but with redundant spaces" do
			it "should return true" do
				subject.correct_answer?("  #{@correct_answers.first}  ").should be_true
			end
		end
	end
end
