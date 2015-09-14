require_relative "./simplecov"
require_relative '../lib/fhir_model'

require 'pry'
require 'minitest/autorun'
require 'bundler/setup'
require 'test/unit'
require 'turn'
require 'nokogiri'
require 'nokogiri/diff'

EXCLUDED_RESOURCES = ['Account','Claim','Coverage','feed','GeneExpression','GeneticAnalysis','GVFMeta',
             'GVFVariant','HealthcareService','Microarray','Person','Protocol',
             'Remittance','Resource','SecurityClaim','SecurityGroup','SecurityPrincipal',
             'Sequence','SequencingAnalysis','SequencingLab','Test','User','VCFMeta','VCFVariant']

class XMLHelper

  def self.diff(orig_xml,xml)
    orig_parsed = Nokogiri::XML(orig_xml)
    parsed = Nokogiri::XML(xml)

    xml_diff = parsed.diff(orig_parsed, added: true, removed: true).to_a
    xml_diff.select! {|e| !(e[1].name == 'schemaLocation' || e[1].name == 'comment' || (e[1].name == 'text' && e[1].content.strip.empty?))}

    XMLHelper.reject_trivial_differences(xml_diff)
  end

  def self.reject_trivial_differences(xml_diff)
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
        rejected << key if left.gsub(/[[:space:]]/,'').gsub(/[^\w]/,'') == right.gsub(/[[:space:]]/,'').gsub(/[^\w]/,'')
      # ignore question marks in some of the XML
      elsif (values.length == 1 && (values[0].strip == '?????' || values[0].gsub(/[[:space:]]/,'').size==0))
        rejected << key
      else
      end
    end
    xml_diff.reject! {|e| rejected.include? e[1].path }
    xml_diff
  end

  def self.get_path(node,stack=[])
    return stack.reverse.join('/') if node.nil?
    begin
      id = node.element_children.select{|x|x.name='id'}.first.attributes['value'].value
      stack << "[#{id}]"
    rescue
    end
    stack << node.name
    get_path(node.try(:parent),stack)
  end

end