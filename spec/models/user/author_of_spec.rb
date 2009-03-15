require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe User, '#author_of?' do
  describe "when user is an author of game" do
    before :each do
      @user = create_user
      @game = create_game :author => @user
    end

    it "returns true" do
      @user.author_of?(@game).should be_true
    end
  end

  describe "when user is not an author of game" do
    before :each do
      @user = create_user
      @game = create_game :author => create_user
    end

    it "returns false" do
      @user.author_of?(@game).should be_false
    end
  end
end
