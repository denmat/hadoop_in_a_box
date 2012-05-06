
task :default => :all

  desc 'run all tasks to setup a vagrant box'
  task :all do
    Rake::Task['Vbox:run'].invoke
    Rake::Task['vagrant_setup:run'].invoke
    Rake::Task['puppet:run'].invoke
    Rake::Task['cleanup:run'].invoke
  end

Dir.glob('**/*.rake').each { |r| import r }
#import "#{Dir.pwd}/#{Dir.glob('*.rake')}"
