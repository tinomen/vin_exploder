#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

RSpec.configure do |c|
  c.filter_run_excluding :couchdb => true
end

task :default => :spec