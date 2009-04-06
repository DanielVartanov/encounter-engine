require 'cucumber/rake/task'

cucumber_options = lambda do |t|
  t.cucumber_opts = '-p rake'
  t.binary = 'bin/cucumber'
end

Cucumber::Rake::Task.new(:features, &cucumber_options)
Cucumber::Rake::FeatureTask.new(:feature, &cucumber_options)