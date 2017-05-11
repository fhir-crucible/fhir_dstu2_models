root = File.expand_path '..', File.dirname(File.absolute_path(__FILE__))

require File.join(root, 'lib', 'fhir_dstu2_models', 'version')
require File.join(root, 'lib', 'fhir_dstu2_models', 'deprecate')

# Need to require Hashable first
require File.join(root, 'lib', 'fhir_dstu2_models', 'bootstrap', 'hashable.rb')
require File.join(root, 'lib', 'fhir_dstu2_models', 'bootstrap', 'json.rb')

Dir.glob(File.join(root, 'lib', 'fhir_dstu2_models', 'bootstrap', '*.rb')).each do |file|
  require file
end
Dir.glob(File.join(root, 'lib', 'fhir_dstu2_models', 'bootstrap', '**', '*.rb')).each do |file|
  require file
end

require File.join(root, 'lib', 'fhir_dstu2_models', 'fhir.rb')

# Require the generated code
Dir.glob(File.join(root, 'lib', 'fhir_dstu2_models', 'fhir', '*.rb')).each do |file|
  require file
end
Dir.glob(File.join(root, 'lib', 'fhir_dstu2_models', 'fhir', '**', '*.rb')).each do |file|
  require file
end

# Require the fluentpath code
Dir.glob(File.join(root, 'lib', 'fhir_dstu2_models', 'fluentpath', '*.rb')).each do |file|
  require file
end

# Require the fhir_ext code
Dir.glob(File.join(root, 'lib', 'fhir_dstu2_models', 'fhir_ext', '*.rb')).each do |file|
  require file
end
