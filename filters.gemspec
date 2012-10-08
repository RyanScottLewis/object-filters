# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "filters"
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Scott Lewis"]
  s.date = "2012-10-08"
  s.description = "This gem provides ActionController::Filters for normal applications."
  s.email = ["c00lryguy@gmail.com"]
  s.files = [".gitignore", "Gemfile", "Rakefile", "VERSION", "filters.gemspec", "lib/filters.rb", "spec/filters_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://rubygems.org/gems/filters"
  s.post_install_message = "This is a placeholder gem... for now. Check back in a few versions!"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Use before, after, and around filters with your objects!"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<version>, ["~> 1"])
      s.add_runtime_dependency(%q<active_support>, ["~> 3"])
    else
      s.add_dependency(%q<version>, ["~> 1"])
      s.add_dependency(%q<active_support>, ["~> 3"])
    end
  else
    s.add_dependency(%q<version>, ["~> 1"])
    s.add_dependency(%q<active_support>, ["~> 3"])
  end
end
