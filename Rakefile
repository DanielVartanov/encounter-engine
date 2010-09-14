desc "add folder step definitions"
task :add_folder_step_definitions do
  `mkdir -p features/step_definitions`
  chdir "features/step_definitions"
  `ls -d ../*/steps`.split("\n").each do |path|
    pp = path.split '/';
    puts `ln -s #{path} #{pp[1]}_steps`
  end
end
