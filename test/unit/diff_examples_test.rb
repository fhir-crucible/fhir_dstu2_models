require 'fileutils'
require 'digest'
require_relative '../test_helper'
require 'nokogiri/diff'

class DiffExamplesTest < Test::Unit::TestCase
 
  ERROR_DIR = File.join('tmp','errors', 'diff')
  EXAMPLE_ROOT = File.join('..','..','..','..','publish')

  # Automatically generate one test method per measure file
  example_files = File.join(EXAMPLE_ROOT, '**', '*-example*.xml')

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p ERROR_DIR
  
  utils = Class.new.extend(FHIR::Formats::Utilities)

  Dir.glob(example_files).each do | example_file |
    root_element = Nokogiri::XML(File.read(example_file)).root.try(:name)
    next if (root_element.nil? || ['Workbook', 'div'].include?(root_element))
    next if !utils.is_fhir_class? "FHIR::#{root_element}"

    # TODO: probably want these eventually
    next if EXCLUDED_RESOURCES.include?(root_element)

    example_name = File.basename(example_file, ".xml")
    dir = File.dirname(example_file)
    parent = dir[dir.index('publish')+7..-1].gsub('/','_')
    define_method("test_#{parent}#{example_name}") do
      run_diff_test(root_element, example_file, "#{parent}#{example_name}")
    end
  end

  def run_diff_test(root_element, example_file, example_name)
    orig_xml = File.read(example_file)
    model = FHIR.const_get(root_element).from_xml orig_xml
    xml = model.to_xml

    xml_diff = XMLHelper.diff(orig_xml,xml)

    if xml_diff.present?
      File.open("#{ERROR_DIR}/#{example_name}.diff", 'w') {|file| xml_diff.each {|change, node| file.write("#{change} #{node.to_s}\t\t#{node.path}\n")}}
      File.open("#{ERROR_DIR}/#{example_name}.xml", 'w') {|file| file.write((Nokogiri.XML(xml) {|x| x.default_xml.noblanks}).to_xml(indent: 2))}
      File.open("#{ERROR_DIR}/#{example_name}_ORIG.xml", 'w') {|file| file.write(orig_xml)}
    end
    assert xml_diff.empty?, "Differences in generated XML vs original"
  end

end
