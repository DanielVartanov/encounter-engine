require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Hint, "#delay_in_minutes" do
  describe "given a hint" do
    before :each do
      @hint = create_hint
    end

    describe "when delay is set" do
      before :each do
        @hint.delay = 600
      end

      it "should return delay in minutes" do
        @hint.delay_in_minutes.should == 10
      end
    end

    describe "when delay_in_minutes is set" do
      before :each do
        @hint.delay_in_minutes = 10
      end

      it "should set delay in seconds " do
        @hint.delay.should == 600
      end
    end

    describe "when delay is nil" do
      before :each do
        @hint.delay = nil
      end

      it "should return nil" do
        @hint.delay_in_minutes.should be_nil
      end
    end

    describe "when delay_in_minutes is a string (came from controller)" do
      before :each do
        @hint.delay_in_minutes = '10'
      end

      it "should handle it correctly" do
        @hint.delay.should == 600
      end
    end
  end
end