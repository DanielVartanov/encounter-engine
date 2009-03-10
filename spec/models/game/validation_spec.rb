require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Game do
  describe "when only whitespaces in name or description" do
    before :each do
      @author = create_user
      @game = Game.new :name => "   \t", :description => "  \t\n\r", :author => @author      
    end

    it "should not be valid" do
      @game.should_not be_valid
      @game.errors.on(:name).should_not be_empty
      @game.errors.on(:description).should_not be_empty
    end
  end
end