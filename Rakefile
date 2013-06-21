require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:features) { |t| t.cucumber_opts = "features --format pretty --tags ~@todo" }
task :default => [ :spec, :features ]

task :spec => 'parser:build'
task :features => 'parser:build'

rule '.rb' => %w[ .kpeg ] do |t|
  sh "rm -f #{t.name}"
  sh "bundle exec kpeg -o #{t.name} #{t.source}"
end

namespace :parser do
  task :build => 'lib/rubby/parser.rb'
end
