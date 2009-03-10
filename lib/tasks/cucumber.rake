require 'cucumber/rake/task'

cucumber_options = lambda do |t|
  t.cucumber_opts = "--language ru"
end

Cucumber::Rake::Task.new(:features, &cucumber_options)
Cucumber::Rake::FeatureTask.new(:feature, &cucumber_options)