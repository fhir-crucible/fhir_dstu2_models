# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "fhir_model"
  s.summary = "A Gem for handling FHIR model in ruby"
  s.description = "A Gem for handling FHIR model in ruby"
  s.email = "aquina@mitre.org"
  s.homepage = "https://github.com/hl7-fhir/fhir-svn"
  s.authors = ["Andre Quina", "Rob Dingwell", "Jason Walonoski", "Janoo Fernandes"]
  s.version = '1.0.0'

  s.files = s.files = `git ls-files`.split("\n")

  s.add_dependency 'tilt'
  s.add_dependency 'rails', '>= 4.0.0'
  s.add_dependency 'mongoid'
  s.add_dependency 'nokogiri'
  s.add_dependency 'mongoid-history'
  s.add_dependency 'date_time_precision'
  s.add_dependency 'bcp47'
  s.add_dependency 'moped'
  s.add_dependency 'pry'
end


