$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dvl/color/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "dvl-color"
  s.version = Dvl::Color::VERSION

  s.required_ruby_version = Gem::Requirement.new('>= 2.0.0')
  s.authors = ['Adam Becker']
  s.summary = 'Generate beautiful, accessible color schemes.'
  s.email = 'adam@dobt.co'
  s.license = 'MIT'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {features,spec}/*`.split("\n")

  s.homepage = 'http://github.com/dobtco/dvl-color'

  s.add_dependency 'chroma', '~> 0.0.1'
  s.add_dependency 'chroma_wcag_contrast', '~> 0.0.1'

  s.add_development_dependency 'fortitude'
  s.add_development_dependency 'rspec'
end
