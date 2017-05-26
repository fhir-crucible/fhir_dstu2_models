# fhir_dstu2_models [![Build Status](https://api.travis-ci.org/fhir-crucible/fhir_dstu2_models.svg?branch=master)](https://travis-ci.org/fhir-crucible/fhir_dstu2_models)

Snapshot of generated FHIR DSTU2 Ruby Models.

Includes support for:
* All FHIR Resources
* XML and JSON
* Extensions
* Profile Validation
* Profile Comparison

### Getting Started

    $ bundle install
    $ bundle exec rake fhir:console

### Resource Basics

Using XML...
```ruby
xml = File.read('patient-example.xml')
patient = FHIR::DSTU2.from_contents(xml)
puts patient.to_xml
```
Using JSON...
```ruby
json = File.read('patient-example.json')
patient = FHIR::DSTU2.from_contents(json)
puts patient.to_json
```
### Validation

Using a base resource definition...
```ruby
sd = FHIR::DSTU2::Definitions.resource_definition('Patient')
sd.validates_resource?(patient) # passing in FHIR::DSTU2::Patient
```
Validation failed? Get the errors and warnings...
```ruby
puts sd.errors
puts sd.warnings
```
# License

Copyright 2014-2017 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
