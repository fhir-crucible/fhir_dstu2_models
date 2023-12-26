# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fhir_dstu2_models/version'

Gem::Specification.new do |spec|
  spec.name          = 'fhir_dstu2_models'
  spec.version       = FHIR::DSTU2::Models::VERSION
  spec.authors       = ['Jason Walonoski', 'Andre Quina', "Michael O'Keefe", 'Robert Scanlon']
  spec.email         = ['jwalonoski@mitre.org']
  spec.licenses      = ['Apache-2.0']

  spec.summary       = %q{A Gem for handling FHIR DSTU2 models in ruby}
  spec.description   = %q{A Gem for handling FHIR DSTU2 models in ruby}
  spec.homepage      = 'https://github.com/fhir-crucible/fhir_dstu2_models'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.0.0'
  spec.add_dependency 'nokogiri', '>= 1.11.4'
  spec.add_dependency 'date_time_precision', '>= 0.8'
  spec.add_dependency 'bcp47', '>= 0.3'
  spec.add_dependency 'mime-types', '>= 3.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'nokogiri-diff'
  spec.add_development_dependency 'rubocop', '1.23.0'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-test'
end
