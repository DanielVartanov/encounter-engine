require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Game, '#finished_teams' do
  describe "when there are several games" do
    before :each do
      @game = create_game
      3.times { create_level :game => @game }

      @another_game = create_game
      3.times { create_level :game => @another_game }
    end

    describe "when there are teams which don't play games" do
      before :each do
        5.times { create_team }
      end

      describe "when there are teams which still play games" do
        before :each do
          3.times { GamePassing.create! :game => @game, :team => create_team, :current_level => @game.levels.second }
          3.times { GamePassing.create! :game => @another_game, :team => create_team, :current_level => @another_game.levels.second }
        end

        describe "when there are teams which finished games" do
          before :each do
            first_team = create_team
            GamePassing.create!(:game => @game, :team => first_team, :finished_at => Time.now)

            second_team = create_team
            GamePassing.create!(:game => @another_game, :team => second_team, :finished_at => Time.now)

            @finished_teams = [first_team]
          end

          describe "when there are even teams which finished both games" do
            before :each do
              super_team = create_team
              GamePassing.create!(:game => @game, :team => super_team, :finished_at => Time.now)
              GamePassing.create!(:game => @another_game, :team => super_team, :finished_at => Time.now)

              @finished_teams << super_team
            end

            it "should return only teams which finished exactly this game" do
              @game.finished_teams.to_set.should == @finished_teams.to_set
            end
          end
        end
      end
    end
  end
end