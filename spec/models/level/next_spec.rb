require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Level do
  before :each do
    @game = create_game
    @another_game = create_game    
    @first_level = create_level :game => @game, :correct_answer => "enfirst"
    create_level :game => @another_game
    @second_level = create_level :game => @game, :correct_answer => "ensecond"
  end

  describe "#next" do
    it "should return next level" do
      @first_level.next.should == @second_level
    end

    it "should return nil if the level is last" do
      @second_level.next.should be_nil
    end
  end
end