require 'rspec/core/rake_task'
require "cucumber/rake/task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w{ --color }
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = %w{ --format progress }
end

task :default => [:spec, :cucumber]
