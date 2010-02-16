require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Level, "multi_question?" do
  before :each do
    @level = create_level
  end

  subject { @level.multi_question?  }

  context "when there is one question" do    
    it { should be_false }
  end

  context "when there are more than one question" do
    before :each do
      create_question :level => @level
    end

    it { should be_true }
  end
end