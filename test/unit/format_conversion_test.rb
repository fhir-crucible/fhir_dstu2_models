require 'fileutils'
require_relative '../test_helper'

class RunConversionTest < Test::Unit::TestCase
 
  ERROR_DIR_JJ = File.join('tmp','errors','format','read-json-write-json')
  ERROR_DIR_XJ = File.join('tmp','errors','format','read-xml-write-json')
  EXAMPLE_ROOT = File.join('..','..','..','..','temp')
  EXAMPLE_JSON_ROOT = File.join('..','..','..','..','temp')
  XSD_ROOT = File.join('..','..','..','..','schema')

  # Automatically generate one test method per example file
  example_xml_files = File.join(EXAMPLE_ROOT, '**', '*-example*.xml')
  example_json_files = File.join(EXAMPLE_JSON_ROOT, '**', '*-example*.json')

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR_JJ) if File.directory?(ERROR_DIR_JJ)
  FileUtils.mkdir_p ERROR_DIR_JJ
 
  FileUtils.rm_rf(ERROR_DIR_XJ) if File.directory?(ERROR_DIR_XJ)
  FileUtils.mkdir_p ERROR_DIR_XJ
   
  example_xml_files = Dir.glob(example_xml_files)
  
  utils = Class.new.extend(FHIR::Formats::Utilities)

  Dir.glob(example_json_files).each do | json_file |
    
    json_basename = File.basename(json_file,'.json')
    json_string = File.open(json_file, 'r:bom|UTF-8', &:read)
    
    xml_file = example_xml_files.find {|f| File.basename(f,'.xml') == json_basename }
    next if xml_file.nil?
    
    xml_string = File.open(xml_file, 'r:bom|UTF-8', &:read)
    
    # Ignoring examples that aren't FHIR
    root_element = Nokogiri::XML(File.read(xml_file)).root.try(:name)
    next if (root_element.nil? || ['Workbook', 'div'].include?(root_element))
    next if !utils.is_fhir_class? "FHIR::#{root_element}"

    # TODO: probably want these eventually
    next if EXCLUDED_RESOURCES.include?(root_element)

    # Generate Test 1 - JSON conversions
    define_method("test_#{json_basename}_json_diff") do
      run_json_diff_test(json_basename,json_file)
    end
    
    # Generate Test 2 - XML-to-JSON Ruby/Java correctness
    define_method("test_#{json_basename}_xml_json_diff") do
      run_xml_json_diff_test(json_basename,json_file,root_element,xml_file)
    end 
    
    # Generate Test 3 - XML/JSON lossiness
  end

  # Test 1 - JSON conversions
  # 1. Inflate from JSON examples (generated w/ Publish)
  # 2. Output FHIR JSON
  # 3. JSON diff (1) and (2)
  def run_json_diff_test(example_name, example_json_file)
    
    example_json_string = File.open(example_json_file, 'r:bom|UTF-8', &:read)
    example_json_hash = JSON.parse(example_json_string)
    
    # Inflate the resource from Patient... it will inflate any FHIR Resource type
    obj = FHIR::Patient.from_fhir_json example_json_string
    parsed_json_string = obj.to_fhir_json
    parsed_json_hash = JSON.parse(parsed_json_string)
    
    #assert parsed_json_hash == example_json_hash
    
    errors = nil
    longer = nil
    longer_name = nil
    shorter = nil
    shorter_name = nil
    if(parsed_json_hash.size > example_json_hash.size)
      begin
        errors = compare(parsed_json_hash,example_json_hash)
      rescue Exception => e
        binding.pry
      end
      longer = parsed_json_hash
      longer_name = 'PRODUCED'
      shorter = example_json_hash
      shorter_name = 'ORIGINAL'
    else
      begin
        errors = compare(example_json_hash,parsed_json_hash)
      rescue Exception => e
        binding.pry
      end      
      longer = example_json_hash
      longer_name = 'ORIGINAL'
      shorter = parsed_json_hash
      shorter_name = 'PRODUCED'
   end
    
    if !errors.nil? and !errors.empty?
      # output to file
      File.open("#{ERROR_DIR_JJ}/#{example_name}.err", 'w:UTF-8') do | file |
        file.write "#{example_name}: #{errors.length} errors\n\n"
        errors.each_with_index do |error,index|
          if error.is_a? Array
            file.write(sprintf("%-8d %-8s %-20s %s\n", index, longer_name, error[0], error[1].to_s))
            file.write(sprintf("%-8d %-8s %-20s %s\n", index, shorter_name, error[0], shorter[error[0]].to_s))
          else
            file.write(sprintf("%-8d %-8s %-20s %s\n", index, longer_name, '?', error.to_s))          
          end
        end
      end
      File.open("#{ERROR_DIR_JJ}/#{example_name}_PRODUCED.json", 'w:UTF-8') {|file| file.write(parsed_json_string)}
      File.open("#{ERROR_DIR_JJ}/#{example_name}_ORIGINAL.json", 'w:UTF-8') {|file| file.write(example_json_string)}      
    end
    
    assert errors.empty?, "#{example_name}: #{errors.length} errors"
  end

  def compare(hasha,hashb)
    return [hasha] if hashb.nil?

    errors = []
    hasha.each do |key,value|
      other = hashb[key]
      if value.is_a?(Array) && !other.is_a?(Array)
        errors << [key,value]
        next
      end 
      if other.is_a?(Array) && !value.is_a?(Array)
        errors << [key,value]
        next
      end
      if value.is_a?(Array)
        value.each_with_index do |item,index|
          itemB = other[index]
          if item.is_a?(Hash)
            errors += compare(item,itemB)
          else
            errors << [key,value] if value!=other
          end
        end
        errors << [key,value] if value.size!=other.size
      elsif value.is_a?(Hash)
        errors += compare(value,other)
      elsif is_a_date_or_time(value) || is_a_date_or_time(other)
          # ignore date time formatting
      else
        errors << [key,value] if value!=other
      end
    end
    errors
  end

  def is_a_date_or_time(value)
    return false if !value.is_a?(String)
    # when 'instant'
    regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))/
    return true if !(regex =~ value).nil?
    # when 'date'
    regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])))/
    return true if !(regex =~ value).nil?        
    # when 'datetime'
    regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?/
    return true if !(regex =~ value).nil?
    # when 'time'
    regex = /([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?/
    return true if !(regex =~ value).nil?
    false
  end
  
  # Test 2 - XML-to-JSON Ruby/Java correctness
  # Compare Ruby-generated JSON with Java-generated JSON
  # 1. Inflate from XML examples
  # 2. Output FHIR JSON
  # 3. JSON diff (2) with JSON examples (generated w/ Publish)
  def run_xml_json_diff_test(example_name, example_json_file, root_element, example_xml_file)
    
    example_json_string = File.open(example_json_file, 'r:bom|UTF-8', &:read)
    example_json_hash = JSON.parse(example_json_string)
    
    # Inflate the resource from XML
    example_xml_string = File.open(example_xml_file, 'r:bom|UTF-8', &:read)
    obj = FHIR.const_get(root_element).from_xml example_xml_string

    parsed_json_string = obj.to_fhir_json
    parsed_json_hash = JSON.parse(parsed_json_string)
    
    #assert parsed_json_hash == example_json_hash
    
    errors = nil
    longer = nil
    longer_name = nil
    shorter = nil
    shorter_name = nil
    if(parsed_json_hash.size > example_json_hash.size)
      begin
        errors = compare(parsed_json_hash,example_json_hash)
      rescue Exception => e
        binding.pry
      end
      longer = parsed_json_hash
      longer_name = 'PRODUCED'
      shorter = example_json_hash
      shorter_name = 'ORIGINAL'
    else
      begin
        errors = compare(example_json_hash,parsed_json_hash)
      rescue Exception => e
        binding.pry
      end
      longer = example_json_hash
      longer_name = 'ORIGINAL'
      shorter = parsed_json_hash
      shorter_name = 'PRODUCED'
   end
    
    if !errors.nil? and !errors.empty?
      # output to file
      File.open("#{ERROR_DIR_XJ}/#{example_name}.err", 'w:UTF-8') do | file |
        file.write "#{example_name}: #{errors.length} errors\n\n"
        errors.each_with_index do |error,index|
          if error.is_a? Array
            file.write(sprintf("%-8d %-8s %-20s %s\n", index, longer_name, error[0], error[1].to_s))
            file.write(sprintf("%-8d %-8s %-20s %s\n", index, shorter_name, error[0], shorter[error[0]].to_s))
          else
            file.write(sprintf("%-8d %-8s %-20s %s\n", index, longer_name, '?', error.to_s))          
          end
        end
      end
      File.open("#{ERROR_DIR_XJ}/#{example_name}_PRODUCED.json", 'w:UTF-8') {|file| file.write(parsed_json_string)}
      File.open("#{ERROR_DIR_XJ}/#{example_name}_ORIGINAL.xml", 'w:UTF-8') {|file| file.write(example_xml_string)}
      File.open("#{ERROR_DIR_XJ}/#{example_name}_ORIGINAL.json", 'w:UTF-8') {|file| file.write(example_json_string)}      
    end
    
    assert errors.empty?, "#{example_name}: #{errors.length} errors"
  end
  
  # Test 3 - XML/JSON lossiness
  # 1. Inflate from XML examples
  # 2. Output FHIR JSON
  # 3. Inflate from (2) JSON
  # 4. Output FHIR XML from (3)
  # 5. Diff XML generated in (1) and (4)  

end