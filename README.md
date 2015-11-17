fhir_dstu2_models
=================

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
xml = File.open('patient-example.xml',&:read)
patient = FHIR::Patient.from_xml(xml)
puts patient.to_xml
```
Using JSON...
```ruby
json = File.open('patient-example.json',&:read)
patient = FHIR::Patient.from_fhir_json(json)
puts patient.to_fhir_json
```
### Validation

Using a base resource definition...
```ruby
sd = FHIR::StructureDefinition.get_base_definition('Patient')
sd.is_valid?(patient) # passing in FHIR::Patient
sd.is_valid?(xml)     # passing in String of XML
sd.is_valid?(json)    # passing in String of JSON
```
Validation failed? Get the errors and warnings...
```ruby
puts sd.errors
puts sd.warnings
```
### Profile Comparison

We include those profiles built into the FHIR core tools... let's compare them...
```ruby
profiles = FHIR::StructureDefinition.get_profiles_for_resource('Patient')
profiles[0].is_compatible?(profiles[1])
```
Profiles not compatible? Get the errors and warnings...
```ruby
puts profiles[0].errors
puts profiles[1].warnings
```
# License

Copyright 2014-2015 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
