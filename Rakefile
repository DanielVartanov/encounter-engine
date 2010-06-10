require 'rubygems'
require 'rake/rdoctask'

require 'merb-core'
require 'merb-core/tasks/merb'

include FileUtils

# Load the basic runtime dependencies; this will include 
# any plugins and therefore plugin rake tasks.
init_env = ENV['MERB_ENV'] || 'rake'
Merb.load_dependencies(:environment => init_env)
     
# Get Merb plugins and dependencies
Merb::Plugins.rakefiles.each { |r| require r } 

# Load any app level custom rakefile extensions from lib/tasks
tasks_path = File.join(File.dirname(__FILE__), "lib", "tasks")
rake_files = Dir["#{tasks_path}/*.rake"]
rake_files.each{|rake_file| load rake_file }

desc "Start runner environment"
task :merb_env do
  Merb.start_environment(:environment => init_env, :adapter => 'runner')
end

require 'spec/rake/spectask'
require 'merb-core/test/tasks/spectasks'
desc 'Default: run spec examples'
task :default => 'spec'

##############################################################################
# ADD YOUR CUSTOM TASKS IN /lib/tasks
# NAME YOUR RAKE FILES file_name.rake
##############################################################################

desc "run after commit"
task :dev_build do
  text = `bundle exec cucumber`

  lines = text.split "\n"

  puts "\n\n"
  puts "Потраченное время : " + lines.pop

  last = lines.pop
  if last =~ /failed/
    steps_failed_line = last
    scenarios_failed_line = lines.pop
  
    puts "\n\n"
    puts "Проваленные сценарии:"
    while !((line = lines.pop) =~ /Failing Scenarios:/) do
      puts line
    end
  
    puts "\n\n"
    puts scenarios_failed_line
    puts steps_failed_line
    puts "\n\n"
  else 
    puts "\n\n"
    puts "Прошли все тесты!"
    puts "\n\n"
  end
end

