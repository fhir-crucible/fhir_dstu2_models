require 'fhir_dstu2_models'
namespace :fhir do
  desc 'console'
  task :console, [] do |_t, _args|
    sh 'bin/console'
  end

  desc 'generate fhir models'
  task :generate, [] do |_t, _args|
    # create a generator and load the definitions
    generator = FHIR::DSTU2::Boot::Generator.new
    # 1. generate the lists of primitive data types, complex types, and resources
    generator.generate_metadata
    # 2. generate the complex data types
    generator.generate_types
    # 3. generate the base Resources
    generator.generate_resources
    # 4. generate extensions?

    # 5. generate profiles?
    if generator.missing_required_expansion
      FHIR::DSTU2.logger.error 'MISSING REQUIRED EXPANSION(S) -- This is a fatal error in the definition files.'
    elsif generator.missing_expansions
      FHIR::DSTU2.logger.info 'Missing expansions can be safely ignored due to weak binding strengths.'
    end
  end

  desc 'preprocess definitions'
  task :preprocess, [] do |_t, _args|
    FileList['lib/fhir_dstu2_models/definitions/structures/*.json'].each do |file|
      FHIR::DSTU2::Boot::Preprocess.pre_process_bundle(file)
    end
    FileList['lib/fhir_dstu2_models/definitions/valuesets/*.json'].each do |file|
      FHIR::DSTU2::Boot::Preprocess.pre_process_bundle(file)
    end
    FileList['lib/fhir_dstu2_models/definitions/schema/*.xsd'].each do |file|
      FHIR::DSTU2::Boot::Preprocess.pre_process_schema(file)
    end
    FileList['lib/fhir_dstu2_models/definitions/dstu2/**/*.json'].each do |file|
      FHIR::DSTU2::Boot::Preprocess.pre_process_bundle(file)
    end
    FileList['lib/fhir_dstu2_models/definitions/dstu2/**/*.xsd'].each do |file|
      FHIR::DSTU2::Boot::Preprocess.pre_process_schema(file)
    end
  end

  desc 'copy artifacts from FHIR::DSTU2 build'
  task :update, [:fhir_build_path] do |_t, args|
    fhir_build_path = args[:fhir_build_path]
    root = File.expand_path '../..', File.dirname(File.absolute_path(__FILE__))
    defns = File.join(root, 'fhir_dstu2_models', 'definitions')

    # copy structure definitions and profiles...
    src = File.join(fhir_build_path, 'publish')
    dest = File.join(defns, 'structures')
    copy_artifacts(['profiles-types.json', 'profiles-resources.json', 'profiles-others.json', 'search-parameters.json', 'extension-definitions.json'], src, dest)

    # copy valuesets and expansions...
    dest = File.join(defns, 'valuesets')
    copy_artifacts(['expansions.json', 'valuesets.json', 'v2-tables.json', 'v3-codesystems.json'], src, dest)

    # copy all the XML schemas
    puts '  Copying XML schemas...'
    files = Dir.glob(File.join(src, '*.xsd'))
    files.map! { |f| File.basename(f) }
    dest = File.join(defns, 'schema')
    copy_artifacts(files, src, dest, false)

    # delete the JSON examples
    dest = File.join(root, 'fhir_dstu2_models', 'examples', 'json')
    puts '  Replacing JSON examples...'
    Dir.glob(File.join(dest, '*')).each { |f| File.delete(f) unless File.directory?(f) }
    # copy the new JSON examples over
    files = Dir.glob(File.join(src, '*.json'))
    files.map! { |f| File.basename(f) }
    files.keep_if { |f| f.include?('example') && !f.include?('canonical') }
    copy_artifacts(files, src, dest, false)
    # copy the qicore examples too
    qicore = File.join(src, 'qicore')
    files = Dir.glob(File.join(qicore, '*.json'))
    files.map! { |f| File.basename(f) }
    files.keep_if { |f| f.include?('example') && !f.include?('canonical') }
    copy_artifacts(files, qicore, dest, false)

    # delete the XML examples
    dest = File.join(root, 'fhir_dstu2_models', 'examples', 'xml')
    puts '  Replacing XML examples...'
    Dir.glob(File.join(dest, '*')).each { |f| File.delete(f) unless File.directory?(f) }
    # copy the new XML examples over
    files = Dir.glob(File.join(src, '*.xml'))
    files.map! { |f| File.basename(f) }
    files.keep_if { |f| f.include?('example') && !f.include?('canonical') }
    copy_artifacts(files, src, dest, false)
    # copy the qicore examples too
    files = Dir.glob(File.join(qicore, '*.xml'))
    files.map! { |f| File.basename(f) }
    files.keep_if { |f| f.include?('example') && !f.include?('canonical') }
    copy_artifacts(files, qicore, dest, false)

    # copy the version info
    copy_artifacts(['version.info'], src, defns)

    puts 'Done.'
  end

  desc 'output invariant expressions from definitions'
  task :invariants, [] do |_t, _args|
    # create a generator and load the definitions
    d = FHIR::DSTU2::Definitions
    defs = d.get_complex_types + d.get_resource_definitions
    invariants = {}
    defs.each do |structure_definition|
      structure_definition['snapshot']['element'].each do |element|
        next unless element['constraint']
        element['constraint'].each do |constraint|
          next unless constraint['expression']
          invariants[constraint['key']] = {
            path: element['path'],
            expression: constraint['expression'],
            human: constraint['human']
          }
        end
      end
    end
    File.open('invariants.txt', 'w:UTF-8') do |file|
      invariants.each do |key, value|
        file.write "#{key}|#{value[:path]}|#{value[:expression]}|#{value[:human]}\n"
      end
    end
    puts 'Wrote invariants into pipe-delimited file: invariants.txt'
  end

  def copy_artifacts(artifacts, src_folder, dest_folder, verbose = true)
    artifacts.each do |artifact|
      puts "  Copying #{artifact}..." if verbose
      src = File.join(src_folder, artifact)
      FileUtils.copy src, dest_folder
    end
  end
end
