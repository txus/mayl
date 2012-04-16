#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'yard'
YARD::Config.load_plugin('yard-tomdoc') 
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = %w(-r README.md)
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['./test/**/*_test.rb']
end

task :doc => :yard
task :default => :test
