# Copyright (c) 2011-2015, HL7, Inc & The MITRE Corporation
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, this 
#       list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice, 
#       this list of conditions and the following disclaimer in the documentation 
#       and/or other materials provided with the distribution.
#     * Neither the name of HL7 nor the names of its contributors may be used to 
#       endorse or promote products derived from this software without specific 
#       prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.

module FHIR
  class Invariants

    attr_accessor :errors
    attr_accessor :warnings
    attr_accessor :append_to_invariant_csv

    cattr_accessor :rules

    @@rules = nil

    def self.load_definitions
      if @@rules.nil?
        filename = File.join(File.dirname(__FILE__),'invariants.json')
        json = File.read(filename)
        @@rules = JSON.parse(json)
      end
    end

    def reset
      FHIR::Invariants.load_definitions if @@rules.nil?
      @errors = []
      @warnings = []
    end

    def is_number?(value)
      true if Float(value) rescue false
    end

    # Checks the given resource against known invariant rules
    def is_valid?(resource,representation='Resource')
      if representation.downcase=='resource'
        if !is_fhir_class?(resource.class.to_s)
          @errors << "Not a FHIR Resource: #{resource.class.to_s}"
          return false
        end
        is_valid_xml? resource.to_xml
      elsif representation.downcase=='xml'
        is_valid_xml? resource
      else
        raise Exception.new "is_valid? unhandled representation: #{representation}"
      end
    end

    def is_valid_xml?(xml)
      reset
      doc = Nokogiri::XML(xml)
      if doc.root.nil?
        @errors << "Not valid xml."
        return false
      end
      doc.root.add_namespace_definition('f', 'http://hl7.org/fhir')
      doc.root.add_namespace_definition('h', 'http://www.w3.org/1999/xhtml')
      
      resource_type = doc.xpath('/*').first.name

      # find all IDs of contained resources...
      contained = doc.xpath("f:#{resource_type}/f:contained/f:*/f:id")
      entries = doc.xpath("f:#{resource_type}/f:entry/f:resource/f:*/f:id")
      fullUrls = doc.xpath("f:#{resource_type}/f:entry/f:fullUrl")
      contained_ids = contained.map{|x|x['value']}
      contained_ids << entries.map{|x|x['value']}
      contained_ids << fullUrls.map{|x|x['value']}
      contained_ids.flatten!

      invariant_file = File.open("invariant_validity.csv",'a:UTF-8') if (@append_to_invariant_csv == true)

      rules = @@rules['resources'][resource_type]
      if(!rules.nil?)
        rules.each do |key,rule|
          path = rule['path']
          path = "f:#{path.gsub('.','/f:')}"
          begin
            elements = doc.xpath(path)
            if !elements.empty?
              elements.each do |element|  
                if key.ends_with?("-ref-1")
                  # special handling for references because Nokogiri doesn't like this invariant xpath
                  refs = element.children.select{|c|c.name=="reference"}
                  refs.each do |r|
                    if r['value'].starts_with?('#') # local reference
                      @errors << "#{key}: #{rule['human']}" if !contained_ids.include?(value[1..-1])
                    end
                  end
                elsif key.ends_with?('-eld-3')
                  val = element.at_xpath('f:max')
                  val = val['value'] if val
                  @errors << "#{key}: #{rule['human']}" if(!val.nil? && !(val=='*' || is_number?(val)))
                elsif key.ends_with?('-eld-10')
                  val = element.at_xpath('f:binding')
                  if val
                    valid = val.xpath(rule['xpath'],FHIR::Formats::XPathFunctions)
                    @errors << "#{key}: #{rule['human']}" if !valid
                  end
                elsif key.ends_with?('-eld-12')
                  val = element.at_xpath('f:binding/f:valueSetUri')
                  val = val['value'] if val
                  @errors << "#{key}: #{rule['human']}" if(!val.starts_with?('http://') || !val.starts_with?('https://'))
                else
                  # test the Xpath function
                  valid = element.xpath(rule['xpath'],FHIR::Formats::XPathFunctions)
                  if !valid
                    if rule['severity'] == 'error'
                      @errors << "#{key}: #{rule['human']}"
                    else
                      @warnings << "{key}: #{rule['human']}"
                    end
                  end
                end
              end
              invariant_file.puts("#{resource_type},#{key},#{path},true,#{rule['xpath']},#{rule['human']}") if (@append_to_invariant_csv == true)
            else
              invariant_file.puts("#{resource_type},#{key},#{path},unknown,#{rule['xpath']},#{rule['human']}") if (@append_to_invariant_csv == true)
            end
          rescue Exception => e
            # invalid xpath expression
            @warnings << "Invalid XPATH 1.0 Expression -- #{key}: #{rule['xpath']}"
            invariant_file.puts("#{resource_type},#{key},#{path},false,#{rule['xpath']},#{rule['human']}") if (@append_to_invariant_csv == true)
          end
        end
      # else
      #   puts "No invariants for: #{resource_type}"
      end

      invariant_file.close if (@append_to_invariant_csv == true)

      @errors.empty?
    end

  end
end
