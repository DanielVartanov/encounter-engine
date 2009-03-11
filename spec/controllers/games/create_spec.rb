require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Games, "#create" do
  describe "security filters" do
    describe "registered user attempts create a game" do
      before :each do
        @user = create_user        
      end

      describe "data is valid" do
        before :each do
          @params = { :game => { :name => "Blablabla#{rand(10000)}", :description => "More blablablablabla" } }
        end

        it "crates a game" do
          lambda do
            perform_request({ :as_user => @user }, @params)
          end.should change(Game, :count).by(1)
        end

        it "assigns current user as an author of the game" do
          @response = perform_request({ :as_user => @user }, @params)
          Game.last.author.id.should == @user.id
        end

        it "redirects to game profile"
      end

      describe "data is invalid" do
        before :each do
          @response = perform_request({ :as_user => @user })
        end

        it "renders a form again"
      end
    end

    describe "a guest attempts to create an invitation" do
      it "raises Unauthenticated exception" do
        assert_unauthenticated { perform_request }
      end
    end
  end

  def perform_request(opts={}, params={})
    dispatch_to Games, :create, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end