require 'cucumber/rake/task'

cucumber_options = lambda do |t|
  # if you want to pass some custom options to cucumber, pass them here
  t.cucumber_opts = '-p rake'
  t.binary = Merb.root / 'bin' / 'cucumber' if File.exist?(Merb.root / 'bin' / 'cucumber')

  # We need use fork cucumber since cucumber > 0.3.4
  t.fork = true

  # Add all requirement like before cucumber<0.3.4
  t.cucumber_opts = ''
  require_list = Array(FileList[File.join(File.dirname(__FILE__),"../../features/**/*.rb")])
  require_list.each do |step_file|
    t.cucumber_opts << '--require'
    t.cucumber_opts << step_file
  end
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

