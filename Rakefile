#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:travis) do |t|
  t.rspec_opts = "--tag ~couchdb"
end

task :default do
  if ENV['TRAVIS']
    Rake::Task[:travis].invoke
  else
    Rake::Task[:spec].invoke
  end
end