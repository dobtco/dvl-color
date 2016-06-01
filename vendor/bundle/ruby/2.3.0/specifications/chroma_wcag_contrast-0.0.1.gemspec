# -*- encoding: utf-8 -*-
# stub: chroma_wcag_contrast 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "chroma_wcag_contrast".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Becker".freeze]
  s.date = "2015-09-10"
  s.email = "adam@dobt.co".freeze
  s.homepage = "https://github.com/ajb/chroma_wcag_contrast".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.3".freeze
  s.summary = "Calculate the contrast ratio between 2 colors. Depends on the chroma library.".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<chroma>.freeze, [">= 0"])
    else
      s.add_dependency(%q<chroma>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<chroma>.freeze, [">= 0"])
  end
end
