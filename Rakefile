#!/usr/bin/env rake

require 'rspec/core/rake_task'
require File.dirname(__FILE__) + '/lib/tumblr/version'

task :default => :test

task :build => :test do
  system 'gem build tumblr_client.gemspec'
end

task :release => :build do
  # tag and push
  system "git tag v#{Tumblr::VERSION}"
  system "git push origin --tags"
  # push the gem
  system "gem push tumblr_client-#{Tumblr::VERSION}.gem"
end

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  fail_on_error = true # be explicit
end
