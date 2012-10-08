require 'rake/version_task'
require 'rspec/core/rake_task'

spec = Gem::Specification.new do |s|
  s.name         = File.basename(__FILE__, '.gemspec')
  s.platform     = Gem::Platform::RUBY
  s.authors      = ['Ryan Scott Lewis']
  s.email        = ['c00lryguy@gmail.com']
  s.homepage     = "http://rubygems.org/gems/#{s.name}"
  s.summary      = 'An MVC framework for for Terminal applications (CLI)'
  s.description  = 'This gem provides a simple and easy MVC framework for use with our command line (terminal) applications.'
  s.require_path = 'lib'
  s.files        = `git ls-files`.lines.to_a.collect { |s| s.strip }
  s.executables  = `git ls-files -- bin/*`.lines.to_a.collect { |s| File.basename(s.strip) }
end

Rake::VersionTask.new do |t|
  t.with_git_tag = true
  t.with_gemspec = spec
end

RSpec::Core::RakeTask.new do |t|
  t.rcov = true
  t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/}
end

task :default => :spec