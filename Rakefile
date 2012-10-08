require 'rake/version_task'
require 'rspec/core/rake_task'

spec = Gem::Specification.new do |s|
  s.name         = 'filters'
  s.platform     = Gem::Platform::RUBY
  s.authors      = ['Ryan Scott Lewis']
  s.email        = ['c00lryguy@gmail.com']
  s.homepage     = "http://rubygems.org/gems/#{s.name}"
  s.summary      = 'Use before, after, and around filters with your objects!'
  s.description  = 'This gem provides ActionController::Filters for normal applications.'
  s.require_path = 'lib'
  s.post_install_message = "This is a placeholder gem... for now. Check back in a few versions!"
  s.files        = `git ls-files`.lines.to_a.collect { |s| s.strip }
  s.executables  = `git ls-files -- bin/*`.lines.to_a.collect { |s| File.basename(s.strip) }
  
  s.add_dependency 'version', '~> 1'
  s.add_dependency 'active_support', '~> 3'
end

Rake::VersionTask.new do |t|
  t.with_git_tag = true
  t.with_gemspec = spec
end

RSpec::Core::RakeTask.new

task :default => :spec