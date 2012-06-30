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

desc "add folder step definitions"
task :add_folder_step_definitions do
  `mkdir -p features/step_definitions`
  chdir "features/step_definitions"
  puts `ln -s ../steps/ common_steps`
  `ls -d ../*/steps`.split("\n").each do |path|
    pp = path.split '/';
    puts `ln -s #{path} #{pp[1]}_steps`
  end
end
