# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

Rake::Task["environment"].enhance do
  puts 'SassC version', SassC::VERSION
end
