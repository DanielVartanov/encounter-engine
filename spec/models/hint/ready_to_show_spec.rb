require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Hint, "#ready_to_show" do
  describe "given a hint with 10 minutes delay" do
    before :each do
      @hint = create_hint :delay => 10.minutes
    end

    describe "when team entered level less than 10 minutes ago" do
      before :each do
        @current_level_entered_at = Time.now - 5.minutes
      end

      it "should return false" do
        @hint.ready_to_show?(@current_level_entered_at).should be_false
      end
    end

    describe "when team entered level more than 10 minutes ago" do
      before :each do
        @current_level_entered_at = Time.now - 11.minutes
      end

      it "should return true" do
        @hint.ready_to_show?(@current_level_entered_at).should be_true
      end
    end
  end
end