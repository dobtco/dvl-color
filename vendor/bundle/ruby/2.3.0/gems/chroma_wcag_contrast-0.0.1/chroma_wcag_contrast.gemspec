$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'chroma_wcag_contrast/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'chroma_wcag_contrast'
  s.version = ChromaWcagContrast::VERSION
  s.required_ruby_version = Gem::Requirement.new('>= 2.0.0')
  s.authors = ['Adam Becker']
  s.summary = 'Calculate the contrast ratio between 2 colors. Depends on the chroma library.'
  s.email = 'adam@dobt.co'
  s.license = 'MIT'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {features,spec}/*`.split("\n")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.homepage = 'https://github.com/ajb/chroma_wcag_contrast'

  s.add_dependency 'chroma'
end
