require 'fileutils'
require 'digest'
require_relative '../test_helper'
require 'nokogiri/diff'

class DiffExamplesTest < Test::Unit::TestCase
 
  ERROR_DIR = File.join('tmp','errors', 'diff')
  EXAMPLE_ROOT = File.join('..','..','..','..','source')

  # Automatically generate one test method per measure file
  example_files = File.join(EXAMPLE_ROOT, '**', '*-example*.xml')

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p ERROR_DIR
  
  Dir.glob(example_files).each do | example_file |
    root_element = Nokogiri::XML(File.read(example_file)).root.try(:name)
    next if (root_element.nil? || ['Workbook', 'div'].include?(root_element))

    # TODO: probably want these eventually
    next if EXCLUDED_RESOURCES.include?(root_element)

    example_name = File.basename(example_file, ".xml")
    define_method("test_#{example_name}") do
      run_diff_test(root_element, example_file, example_name)
    end
  end

  def run_diff_test(root_element, example_file, example_name)
    orig_xml = File.read(example_file)
    model = FHIR.const_get(root_element).from_xml orig_xml

    xml = model.to_xml
    orig_parsed = Nokogiri::XML(orig_xml)
    parsed = Nokogiri::XML(xml)

    xml_diff = parsed.diff(orig_parsed, added: true, removed: true).to_a
    xml_diff.select! {|e| !(e[1].name == 'schemaLocation' || e[1].name == 'comment' || (e[1].name == 'text' && e[1].content.strip.empty?))}

    reject_trivial_differences(xml_diff)

    if xml_diff.present?
      File.open("#{ERROR_DIR}/#{example_name}.diff", 'w') {|file| xml_diff.each {|change, node| file.write("#{change} #{node.to_s}\t\t#{node.path}\n")}}
      File.open("#{ERROR_DIR}/#{example_name}.xml", 'w') {|file| file.write((Nokogiri.XML(xml) {|x| x.default_xml.noblanks}).to_xml(indent: 2))}
      File.open("#{ERROR_DIR}/#{example_name}_ORIG.xml", 'w') {|file| file.write(orig_xml)}
    end
    assert xml_diff.empty?, "Differences in generated XML vs original"

  end

  def reject_trivial_differences(xml_diff)
    rejected = []
    change_map = {}
    xml_diff.each do |change, node| 
      change_map[node.path] ||= []
      change_map[node.path] << node.to_s
    end
    change_map.each do |key, values|
      if (values.length == 2)
        left = values[0]
        right = values[1]
        rejected << key if(Float(left) == Float(right)) rescue nil
        rejected << key if(DateTime.parse(left) == DateTime.parse(right)) rescue nil
        rejected << key if left.squish == right.squish

      # ignore question marks in some of the XML
      elsif (values.length == 1 && values[0].strip == '?????')
        rejected << key
      else
      end
    end
    xml_diff.reject! {|e| rejected.include? e[1].path }
  end

end