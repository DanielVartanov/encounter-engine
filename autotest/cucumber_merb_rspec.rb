require File.join( File.dirname(__FILE__), 'merb_rspec' ) 
require "autotest/cucumber_mixin"
class Autotest::CucumberMerbRspec < Autotest::MerbRspec
  include CucumberMixin
  def cucumber
    `which cucumber`.chomp
  end
end
