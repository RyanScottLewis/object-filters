# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "filters"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Scott Lewis"]
  s.date = "2012-10-08"
  s.description = "This gem provides a simple and easy MVC framework for use with our command line (terminal) applications."
  s.email = ["c00lryguy@gmail.com"]
  s.files = [".gitignore", "Gemfile", "Rakefile", "VERSION", "lib/filters.rb", "lib/filters/version.rb", "spec/filters_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://rubygems.org/gems/filters"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "An MVC framework for for Terminal applications (CLI)"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
