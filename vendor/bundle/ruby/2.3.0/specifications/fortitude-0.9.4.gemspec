# -*- encoding: utf-8 -*-
# stub: fortitude 0.9.4 ruby lib
# stub: ext/fortitude_native_ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "fortitude".freeze
  s.version = "0.9.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrew Geweke".freeze]
  s.date = "2015-02-11"
  s.description = "Views Are Code: use all the power of Ruby to build views in your own language.".freeze
  s.email = ["andrew@geweke.org".freeze]
  s.extensions = ["ext/fortitude_native_ext/extconf.rb".freeze]
  s.files = ["ext/fortitude_native_ext/extconf.rb".freeze]
  s.homepage = "https://github.com/ageweke/fortitude".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.3".freeze
  s.summary = "Views Are Code: use all the power of Ruby to build views in your own language.".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0"])
      s.add_runtime_dependency(%q<ref>.freeze, [">= 1.0.5"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.99"])
      s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0"])
      s.add_development_dependency(%q<json>.freeze, [">= 0"])
      s.add_development_dependency(%q<tilt>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<oop_rails_server>.freeze, [">= 0.0.7"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0"])
      s.add_dependency(%q<ref>.freeze, [">= 1.0.5"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.99"])
      s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<tilt>.freeze, ["~> 2.0"])
      s.add_dependency(%q<oop_rails_server>.freeze, [">= 0.0.7"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0"])
    s.add_dependency(%q<ref>.freeze, [">= 1.0.5"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.99"])
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<tilt>.freeze, ["~> 2.0"])
    s.add_dependency(%q<oop_rails_server>.freeze, [">= 0.0.7"])
  end
end
