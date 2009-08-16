require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Game, '#created_by?' do
  describe "when user is an author of game" do
    before :each do
      @user = create_user
      @game = create_game :author => @user
    end

    it "returns true" do
      @game.created_by?(@user).should be_true
    end
  end

  describe "when user is not an author of game" do
    before :each do
      @user = create_user
      @game = create_game :author => create_user
    end

    it "returns false" do
      @game.created_by?(@user).should be_false
    end
  end
end
