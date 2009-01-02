require 'cucumber/rake/task'

cucumber_options = proc do |t|
  t.binary        = Merb.root / 'bin' / 'cucumber'
  t.cucumber_opts = "--language ru"
end

Cucumber::Rake::Task.new(:features, &cucumber_options)
Cucumber::Rake::FeatureTask.new(:feature, &cucumber_options)
namespace :merb_cucumber do 
  task :test_env do
    Merb.start_environment(:environment => "test", :adapter => 'runner')
  end
end


task :features => 'merb_cucumber:test_env'
task :feature  => 'merb_cucumber:test_env'

