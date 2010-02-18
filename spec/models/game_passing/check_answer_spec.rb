require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe GamePassing, "#check_answer!" do
  before :each do
    @game = create_game
    @first_level = create_level :game => @game, :correct_answer => "enfirst"
    @second_level = create_level :game => @game
    @final_level = create_level :game => @game, :correct_answer => "enfinish"
    @team = create_team
  end

  describe "when current level is any middle or first level" do
		before :each do
			@game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @first_level
		end

    describe "when answer is wrong" do
      before :each do
        @result = @game_passing.check_answer!('enblablablablabla')
      end

      it "should return false" do
        @result.should be_false
      end

      it "should not change current_level" do
        @game_passing.current_level.should == @first_level
      end
    end

    describe "when answer is correct" do
      before :each do
        @result = @game_passing.check_answer!(@first_level.questions.first.answer)
      end

      it "should return true" do
        @result.should be_true
      end

      it "should set next level as current" do        
        @game_passing.current_level.should == @second_level
      end

      it "should not set finished_at" do
        @game_passing.finished_at.should be_nil
      end
    end

    describe "when answer contains redundant spaces" do
      before :each do
        @result = @game_passing.check_answer!("   #{@first_level.questions.first.answer}   ")
      end

      it "should return true" do
        @result.should be_true
      end
    end
  end

	describe "when current level contains several questions" do
		before :each do
			@second_level.questions = [
				Question.create!(:answer => 'encode1'),
				Question.create!(:answer => 'encode2')
			]

			@game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @second_level
		end

		describe "at the beginning" do
			describe "when answer is correct" do
				it "should add an element to #answered_questions" do
          @game_passing.check_answer!('encode1')
          @game_passing.answered_questions.should == [@second_level.questions.first]
				end
			end

			describe "when answer is wrong" do
				it "should not add an element to #answered_questions" do
					lambda { @game_passing.check_answer!('enblablablabla') }.should_not change(@game_passing.answered_questions, :size)
				end
			end
		end

		describe "when passed all questions but one" do
			before :each do
				@game_passing.check_answer!('encode1')
			end

			describe "when correct answer is entered twice" do
				before :each do
					@return_value = @game_passing.check_answer!('encode1')
				end
			
				it "return false" do
					@return_value.should be_false
				end

				it "should stay on the same level" do
					@game_passing.current_level.should == @second_level
				end
			end

			describe "when all level questions are answered" do
				before :each do
					@game_passing.check_answer!('encode2')
				end

				it "should pass the whole level" do
					@game_passing.current_level.should == @final_level
				end

        it "should reset answered_questions" do
          @game_passing.answered_questions.should be_empty
        end
			end
		end
	end

  describe "when current level is the last level" do
    before :each do
      @current_time = Time.now
      Time.stub(:now => @current_time)
      @game_passing = GamePassing.create! :game => @game, :team => @team, :current_level => @final_level
    end

    describe "when answer is correct" do
      before :each do
        @result = @game_passing.check_answer!(@final_level.questions.first.answer)
      end

      it "should return true" do
        @result.should be_true
      end

      it "should set current level to nil" do
        @game_passing.current_level.should be_nil
      end

      it "should set finished_at to current time" do
        @game_passing.finished_at.should == @current_time
      end
    end
  end
end
