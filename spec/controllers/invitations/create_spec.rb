require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Invitations, "#create" do
  describe "captain invites a new user" do
    before :each do
      @captain = create_user
      @user = create_user
      @team = create_team :captain => @captain
      @params = { :to_user => @user.email }
    end

    it "redirects back to team room with notice" do
      pending
      # perform_request @params, :as_user => @captain
      # Пользователю @user.email выслано приглашение
    end

    it "creates a new invitation" do
      lambda do
        perform_request @params, :as_user => @captain
      end.should change(Invitation, :count).by(1)

      invitation = Invitation.last
      invitation.from_team.should == @team
      invitation.to_user.should == @user
    end
  end

  describe "a regular team member attepmts to invite user" do
    before :each do
      @captain = create_user
      @member = create_user
      @team = create_team :captain => @captain, :members => [@member]
    end

    it "raises Unauthorized exception" do
      assert_unauthorized { perform_request :as_user => @member }
    end
  end

  describe "a guest attempts to create an invitation" do
    it "raises Unauthenticated exception" do
      assert_unauthenticated { perform_request }      
    end
  end

  describe "captain attempts to invite a member of another team" do
    before :each do
      @user = create_user
      create_team :captain => create_user, :members => [@user]

      @captain = create_user
      @team = create_team :captain => @captain
      @params = { :to_user => @user.email }
    end

    it "redirects with error" do
      pending
      # Пользователь @user.email уже член команды @user.team.name
    end

    it "does not create a new invitation" do
      lambda do
        perform_request @params, :as_user => @captain
      end.should_not change(Invitation, :count)
    end    
  end

  describe "captain attempts to invite a member of his own team" do
    before :each do
      @user = create_user
      @captain = create_user
      @team = create_team :captain => @captain, :members => [@user]
      @params = { :to_user => @user.email }
    end

    it "redirects with error" do
      pending
      # Пользователь @user.email уже и так член вашей команды
    end

    it "does not create a new invitation" do
      lambda do
        perform_request @params, :as_user => @captain
      end.should_not change(Invitation, :count)
    end
  end

  describe "captain attempts to invite himself :-)" do
    before :each do
      @captain = create_user
      @team = create_team :captain => @captain
      @params = { :to_user => @captain.email }
    end

    it "redirects with error" do
      pending
      # Да вы там совсем обкурились?!
    end

    it "does not create a new invitation" do
      lambda do
        perform_request @params, :as_user => @captain
      end.should_not change(Invitation, :count)
    end
  end

  describe "captain attempts to invite someone twice" do
    before :each do
      @captain = create_user
      @user = create_user
      @team = create_team :captain => @captain
      @params = { :to_user => @user.email }
      
      perform_request @params, :as_user => @captain
    end

    it "redirects with error" do
      pending
      # perform_request @params, :as_user => @captain # ещё один раз, второй
      # Ему вы приглашение уже высылали
    end

    it "does not create a new invitation" do
      lambda do
        perform_request @params, :as_user => @captain
      end.should_not change(Invitation, :count)
    end
  end

  describe "captain attempts without providing recipient email" do
    before :each do
      @captain = create_user
      @team = create_team :captain => @captain
      @params = {}      
    end

    it "redirects with error" do
      pending
      # Вы не указали пользователя
    end

    it "does not create a new invitation" do
      lambda do
        perform_request @params, :as_user => @captain
      end.should_not change(Invitation, :count)
    end
  end

  describe "captain attempts providing an unexistant recipient email" do
    before :each do
      @captain = create_user
      @team = create_team :captain => @captain

      @unexistant_email = "some" + rand(100000).to_s + "@email.com"
      @params = { :to_user => @unexistant_email }
    end

    it "redirects with error" do
      pending
      # Пользователя с адресом @unexistant_email не существует
    end

    it "does not create a new invitation" do
      lambda do
        perform_request @params, :as_user => @captain
      end.should_not change(Invitation, :count)
    end
  end

  def perform_request(params={}, opts={})
    dispatch_to Invitations, :create, params do |controller|
      controller.session.stub!(:authenticated?).and_return(opts.key?(:as_user))
      controller.session.stub!(:user).and_return(opts[:as_user])
    end
  end
end