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
  class StructureDefinition

    attr_accessor :finding
    attr_accessor :errors
    attr_accessor :warnings
    cattr_accessor :base_definitions

    @@base_definitions = nil
    @@other_definitions = nil
    @@type_definitions = nil
    @@extension_definitions = nil

    def self.load_definitions
      if @@base_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'profiles-resources.xml')
        xml = File.read(filename)
        @@base_definitions = FHIR::Bundle.from_xml(xml)
      end
      if @@other_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'profiles-others.xml')
        xml = File.read(filename)
        @@other_definitions = FHIR::Bundle.from_xml(xml)
      end
      if @@type_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'profiles-types.xml')
        xml = File.read(filename)
        @@type_definitions = FHIR::Bundle.from_xml(xml)
      end
      if @@extension_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'extension-definitions.xml')
        xml = File.read(filename)
        @@extension_definitions = FHIR::Bundle.from_xml(xml)
      end
    end

    def self.get_base_definition(resource_name)
      return nil if resource_name.nil?
      load_definitions

      @@base_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.xmlId == resource_name || entry.resource.name == resource_name || entry.resource.url == resource_name)
            return entry.resource
          end
        end
      end

      nil
    end

    def self.get_profiles_for_resource(resource_name)
      results = []
      definition = FHIR::StructureDefinition.get_base_definition(resource_name)
      if !definition.nil?
        @@other_definitions.entry.each do |entry|
          if entry.resourceType == 'StructureDefinition'
            if !entry.resource.nil? && entry.resource.base==definition.url
              results << entry.resource
            end
          end
        end
      end
      results
    end

    def self.get_other_definition(definition_name)
      return nil if definition_name.nil?
      load_definitions
      @@other_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.xmlId == definition_name || entry.resource.name == definition_name || entry.resource.url == definition_name)
            return entry.resource
          end
        end
      end
      nil
    end

    def self.get_type_definition(type_name)
      return nil if type_name.nil?
      load_definitions
      @@type_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.xmlId == type_name || entry.resource.name == type_name)
            return entry.resource
          end
        end
      end
      nil
    end

    def self.get_extension_definition(extension_name)
      return nil if extension_name.nil?
      load_definitions
      @@extension_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.xmlId == extension_name || entry.resource.url == extension_name)
            return entry.resource
          end
        end
      end
      nil
    end

    def self.find_all_flaws
      load_definitions
      all_flaws = []
      begin
        @@other_definitions.entry.each do |entry|
          if entry.resourceType == 'StructureDefinition'
            if !entry.resource.nil?
              base = get_base_definition(entry.resource.base)
              if base.nil? || base.snapshot.nil?
                puts "Skipping #{entry.resource.xmlId} with base #{entry.resource.base}"
                next
              end
              base_elements = base.snapshot.element.map {|e| e.path}
              profile_elements = entry.resource.snapshot.element.map {|e| e.path }
              missing = base_elements - profile_elements
              if !missing.nil?
                missing.each do |m|
                  all_flaws << "#{entry.resource.xmlId} is missing #{m} from #{base.xmlId}"
                end
              end
            end
          end
        end
      rescue Exception => ex
        binding.pry
      end
      all_flaws
    end
    
    # -------------------------------------------------------------------------
    #                            Profile Comparison
    # -------------------------------------------------------------------------

    # Checks whether or not "another_definition" is compatible with this definition.
    # If they have conflicting elements, restrictions, bindings, modifying extensions, etc.
    def is_compatible?(another_definition)
      @errors = []
      @warnings = []

      @finding = FHIR::StructureDefinitionFinding.new
      @finding.resourceType = snapshot.element[0].path
      @finding.profileIdA = xmlId
      @finding.profileIdB = another_definition.xmlId if another_definition.respond_to?(:xmlId)

      if !(another_definition.is_a? FHIR::StructureDefinition)
        @errors << @finding.error('','','Not a StructureDefinition','StructureDefinition',"#{another_definition.class.name}")
        return false
      elsif another_definition.snapshot.element[0].path!=snapshot.element[0].path
        @errors << @finding.error('','','Incompatible resourceType',@finding.resourceType, "#{another_definition.snapshot.element[0].path}")
        return false
      end

      left_elements = Array.new(snapshot.element)
      right_elements = Array.new(another_definition.snapshot.element)

      left_paths = left_elements.map { |e| e.path }
      right_paths = right_elements.map { |e| e.path }

      # StructureDefinitions don't always include all base attributes (for example, of a ContactPoint)
      # if nothing is modified from the base definition, so we have to add them in if they are missing.
      base_definition = FHIR::StructureDefinition.get_base_definition(snapshot.element[0].path)
      base_elements = base_definition.snapshot.element

      left_missing = right_paths - left_paths
      # left_missing_roots = left_missing.map{|e| e.split('.')[0..-2].join('.') }.uniq
      add_missing_elements(xmlId,left_missing,left_elements,base_elements)

      right_missing = left_paths - right_paths
      # right_missing_roots = right_missing.map{|e| e.split('.')[0..-2].join('.') }.uniq
      add_missing_elements(another_definition.xmlId,right_missing,right_elements,base_elements)

      # update paths
      left_paths = left_elements.map { |e| e.path }
      right_paths = right_elements.map { |e| e.path }

      # recalculate the missing attributes
      left_missing = right_paths - left_paths
      right_missing = left_paths - right_paths

      # generate warnings for missing fields (ignoring extensions)
      left_missing.each do |e|
        if !e.include? 'extension'
          elem = get_element_by_path(e,right_elements)
          if !elem.min.nil? && elem.min > 0
            @errors << @finding.error(e,'min','Missing REQUIRED element','Missing',"#{elem.min}")
          elsif elem.isModifier==true
            @errors << @finding.error(e,'isModifier','Missing MODIFIER element','Missing',"#{elem.isModifier}")
          else
            @warnings << @finding.warning(e,'','Missing element','Missing','Defined')
          end
        end
      end
      right_missing.each do |e|
        if !e.include? 'extension'
          elem = get_element_by_path(e,left_elements)
          if !elem.min.nil? && elem.min > 0
            @errors << @finding.error(e,'min','Missing REQUIRED element',"#{elem.min}",'Missing')
          elsif elem.isModifier==true
            @errors << @finding.error(e,'isModifier','Missing MODIFIER element',"#{elem.isModifier}",'Missing')
          else
            @warnings << @finding.warning(e,'','Missing element','Defined','Missing')
          end
        end
      end

      left_extensions = []
      right_extensions = []

      # compare elements, starting with the elements in this definition
      left_elements.each do |x|
        if x.path.include? 'extension' 
          # handle extensions separately
          left_extensions << x
        else
          y = get_element_by_path(x.path,right_elements)
          compare_element_definitions(x,y,another_definition)
        end
      end

      # now compare elements defined in the other definition, if we haven't already looked at them
      right_elements.each do |y|
        if y.path.include? 'extension' 
          # handle extensions separately
          right_extensions << y
        elsif left_missing.include? y.path
          x = get_element_by_path(y.path,left_elements)
          compare_element_definitions(x,y,another_definition)
        end
      end      

      # finally, compare the extensions.
      checked_extensions = []
      left_extensions.each do |x|
        y = get_extension(x.name,right_extensions)
        if !y.nil?
          # both profiles share an extension with the same name
          checked_extensions << x.name
          compare_extension_definition(x,y,another_definition)
        end
        y = nil
        y = get_extension(x.fhirType[0].profile,right_extensions)
        if !y.nil? && x.name!=y.name
          # both profiles share the same extension definition but with a different name
          checked_extensions << x.name
          checked_extensions << y.name
          compare_element_definitions(x,y,another_definition)
        end
      end
      right_extensions.each do |y|
        next if checked_extensions.include?(y.name)
        x = get_extension(y.name,left_extensions)
        if !x.nil?
          # both profiles share an extension with the same name
          checked_extensions << y.name
          compare_extension_definition(x,y,another_definition)
        end
        x = nil
        x = get_extension(y.fhirType[0].profile,left_extensions)
        if !x.nil? && x.name!=y.name && !checked_extensions.include?(x.name)
          # both profiles share the same extension definition but with a different name
          checked_extensions << x.name
          checked_extensions << y.name
          compare_element_definitions(x,y,another_definition)
        end
      end
      @errors.flatten!
      @warnings.flatten!
      @errors.size==0
    end

    def get_element_by_path(path,elements=snapshot.element)
      elements.each do |element|
        return element if element.path==path
      end
      nil
    end

    def get_extension(extension,elements=snapshot.element)
      elements.each do |element|
        if element.path.include?('extension') || element.fhirType.map{|t|t.code}.include?('Extension')
          return element if element.name==extension || element.fhirType.map{|t|t.profile}.include?(extension)
        end
      end
      nil
    end

    #private
    # name -- name of the profile we're fixing
    # missing_paths -- list of paths that we're adding
    # elements -- list of elements currently defined in the profile
    # base_elements -- list of elements defined in the base resource the profile extends
    def add_missing_elements(name,missing_paths,elements,base_elements)
      variable_paths = elements.map{|e|e.path}.grep(/\[x\]/).map{|e|e[0..-4]}
      variable_paths << base_elements.map{|e|e.path}.grep(/\[x\]/).map{|e|e[0..-4]}
      variable_paths.flatten!.uniq!
      
      missing_paths.each do |path|
        # Skip extensions
        next if path.include? 'extension'

        # Skip the variable paths that end with "[x]"
        next if variable_paths.any?{|variable| path.starts_with?(variable)}

        elem = get_element_by_path(path,base_elements)
        if !elem.nil?
          # _DEEP_ copy
          elements << FHIR::ElementDefinition.from_fhir_json(elem.to_fhir_json)
          next
        end

        x = path.split('.')
        root = x.first(x.size-1).join('.')
        if root.include? '.'
          # get the root element to fill in the details
          elem = get_element_by_path(root,elements)
          # get the data type definition to fill in the details
          # assume missing elements are from first data type (gross)
          next if elem.fhirType.nil? || elem.fhirType.empty?
          type_def = FHIR::StructureDefinition.get_type_definition(elem.fhirType[0].code)
          next if type_def.nil?
          type_elements = Array.new(type_def.snapshot.element)
          # _DEEP_ copy
          type_elements.map! do |e| #{|e| FHIR::ElementDefinition.from_fhir_json(e.to_fhir_json) }
            FHIR::ElementDefinition.from_fhir_json(e.to_fhir_json)
          end
          # Fix path names
          type_root = String.new(type_elements[0].path)
          type_elements.each { |e| e.path.gsub!(type_root,root) }
          # finally, add the missing element definitions
          # one by one -- only if they are not already present (i.e. do not override)
          type_elements.each do |x|
            y = get_element_by_path(x.path,elements)
            if y.nil?
              elements << x
            # else
            #   @warnings << "StructureDefinition #{name} already contains #{x.path}"
            end
          end
          elements.uniq!
        # else
        #   binding.pry
        #   @warnings << "StructureDefinition #{name} missing -- #{path}"
        end
      end
    end

    #private
    def compare_extension_definition(x,y,another_definition)
      x_profiles = x.fhirType.map{|t|t.profile}
      y_profiles = y.fhirType.map{|t|t.profile}
      x_only = x_profiles - y_profiles
      y_only = y_profiles - x_profiles
      shared = x_profiles - x_only

      if !shared.nil? && shared.size==0
        # same name, but different profiles
        # maybe the profiles are the same, just with different URLs... 
        # ... so we have to compare them, if we can.
        @warnings << @finding.warning("#{x.path} (#{x.name})",'type.profile','Different Profiles',"#{x_profiles}","#{y_profiles}")
        x_extension = FHIR::StructureDefinition.get_extension_definition(x.fhirType[0].profile)
        y_extension = FHIR::StructureDefinition.get_extension_definition(y.fhirType[0].profile)
        if !x_extension.nil? && !y_extension.nil?
          x_extension.is_compatible?(y_extension)
          @errors << x_extension.errors
          @warnings << x_extension.warnings
        else
          @warnings << @finding.warning("#{x.path} (#{x.name})",'','Could not find extension definitions to compare.','','')
        end
      else
        compare_element_definitions(x,y,another_definition)
      end
    end

    #private
    def compare_element_definitions(x,y,another_definition)
      return if x.nil? || y.nil? || another_definition.nil?

      # check cardinality 
      x_min = x.min || 0
      x_max = (x.max == '*') ? Float::INFINITY : x.max.to_i
      y_min = y.min || 0
      y_max = (y.max == '*') ? Float::INFINITY : y.max.to_i

      if x_min.nil? || x.max.nil? || y_min.nil? || y.max.nil?
        @errors << @finding.error("#{x.path}",'min/max','Unknown cardinality',"#{x_min}..#{x.max}","#{y_min}..#{y.max}")
      elsif (x_min > y_max) || (x_max < y_min)
        @errors << @finding.error("#{x.path}",'min/max','Incompatible cardinality',"#{x_min}..#{x.max}","#{y_min}..#{y.max}")
      elsif (x_min != y_min) || (x_max != y_max)
        @warnings << @finding.warning("#{x.path}",'min/max','Inconsistent cardinality',"#{x_min}..#{x.max}","#{y_min}..#{y.max}")
      end

      # check data types
      x_types = x.fhirType.map {|t| t.code }
      y_types = y.fhirType.map {|t| t.code }
      x_only = x_types - y_types
      y_only = y_types - x_types
      shared = x_types - x_only

      if !shared.nil? && shared.size==0 && x_types.size>0 && y_types.size>0 && x.constraint.size > 0 && y.constraint.size > 0
        @errors << @finding.error("#{x.path}",'type.code','Incompatible data types',"#{x_types}","#{y_types}")
      end
      if !x_only.nil? && x_only.size > 0
        @warnings << @finding.warning("#{x.path}",'type.code','Allows additional data types',"#{x_only}","not allowed")
      end
      if !y_only.nil? && y_only.size > 0
        @warnings << @finding.warning("#{x.path}",'type.code','Allows additional data types','not allowed',"#{y_only}")
      end

      # check bindings 
      if x.binding.nil? && !y.binding.nil?
        val = y.binding.valueSetUri || y.binding.valueSetReference.try(:reference) || y.binding.description
        @warnings << @finding.warning("#{x.path}",'binding','Inconsistent binding','',val)
      elsif !x.binding.nil? && y.binding.nil?
        val = x.binding.valueSetUri || x.binding.valueSetReference.try(:reference) || x.binding.description
        @warnings << @finding.warning("#{x.path}",'binding','Inconsistent binding',val,'')
      elsif !x.binding.nil? && !y.binding.nil?
        x_vs = x.binding.valueSetUri || x.binding.valueSetReference.try(:reference)
        y_vs = y.binding.valueSetUri || y.binding.valueSetReference.try(:reference) 
        if x_vs != y_vs
          if x.binding.strength=='required' || y.binding.strength=='required'
            @errors << @finding.error("#{x.path}",'binding.strength','Incompatible bindings',"#{x.binding.strength} #{x_vs}","#{y.binding.strength} #{y_vs}")
          else 
            @warnings << @finding.warning("#{x.path}",'binding.strength','Inconsistent bindings',"#{x.binding.strength} #{x_vs}","#{y.binding.strength} #{y_vs}")
          end
        end
      end

      # check default values
      if x.defaultValue.try(:type) != y.defaultValue.try(:type)
        @errors << @finding.error("#{x.path}",'defaultValue','Incompatible default type',"#{x.defaultValue.try(:type)}","#{y.defaultValue.try(:type)}")
      end
      if x.defaultValue.try(:value) != y.defaultValue.try(:value)
        @errors << @finding.error("#{x.path}",'defaultValue','Incompatible default value',"#{x.defaultValue.try(:value)}","#{y.defaultValue.try(:value)}")
      end

      # check meaning when missing
      if x.meaningWhenMissing != y.meaningWhenMissing
        @errors << @finding.error("#{x.path}",'meaningWhenMissing','Inconsistent missing meaning',"#{x.meaningWhenMissing.gsub(',',';')}","#{y.meaningWhenMissing.gsub(',',';')}")
      end        

      # check fixed values
      if x.fixed.try(:type) != y.fixed.try(:type)
        @errors << @finding.error("#{x.path}",'fixed','Incompatible fixed type',"#{x.fixed.try(:type)}","#{y.fixed.try(:type)}")
      end
      if x.fixed != y.fixed
        xfv = ''
        yfv = ''
        xfv = x.fixed.try(:value) 
        xfv = xfv.to_xml.gsub(/\n/,'') if x.fixed.try(:value).methods.include?(:to_xml)
        yfv = y.fixed.try(:value)
        yfv = yfv.to_xml.gsub(/\n/,'') if y.fixed.try(:value).methods.include?(:to_xml)
        @errors << @finding.error("#{x.path}",'fixed','Incompatible fixed value',"#{xfv}","#{yfv}")
      end

      # check min values
      if x.min.try(:type) != y.min.try(:type)
        @errors << @finding.error("#{x.path}",'min','Incompatible min type',"#{x.min.try(:type)}","#{y.min.try(:type)}")
      end
      if x.min.try(:value) != y.min.try(:value)
        @errors << @finding.error("#{x.path}",'min','Incompatible min value',"#{x.min.try(:value)}","#{y.min.try(:value)}")
      end

      # check max values
      if x.max.try(:type) != y.max.try(:type)
        @errors << @finding.error("#{x.path}",'max','Incompatible max type',"#{x.max.try(:type)}","#{y.max.try(:type)}")
      end
      if x.max.try(:value) != y.max.try(:value)
        @errors << @finding.error("#{x.path}",'max','Incompatible max value',"#{x.max.try(:value)}","#{y.max.try(:value)}")
      end

      # check pattern values
      if x.pattern.try(:type) != y.pattern.try(:type)
        @errors << @finding.error("#{x.path}",'pattern','Incompatible pattern type',"#{x.pattern.try(:type)}","#{y.pattern.try(:type)}")
      end
      if x.pattern.try(:value) != y.pattern.try(:value)
        @errors << @finding.error("#{x.path}",'pattern','Incompatible pattern value',"#{x.pattern.try(:value)}","#{y.pattern.try(:value)}")
      end

      # maxLength (for Strings)
      if x.maxLength != y.maxLength
        @warnings << @finding.warning("#{x.path}",'maxLength','Inconsistent maximum length',"#{x.maxLength}","#{y.maxLength}")
      end

      # constraints
      x_constraints = x.constraint.map {|t| t.xpath }
      y_constraints = y.constraint.map {|t| t.xpath }
      x_only = x_constraints - y_constraints
      y_only = y_constraints - x_constraints
      shared = x_constraints - x_only

      if !shared.nil? && shared.size==0 && x.constraint.size > 0 && y.constraint.size > 0
        @errors << @finding.error("#{x.path}",'constraint.xpath','Incompatible constraints',"#{x_constraints.map{|x|x.gsub(',',';')}.join(' && ')}","#{y_constraints.map{|x|x.gsub(',',';')}.join(' && ')}")
      end
      if !x_only.nil? && x_only.size > 0
        @errors << @finding.error("#{x.path}",'constraint.xpath','Additional constraints',"#{x_constraints.map{|x|x.gsub(',',';')}.join(' && ')}",'')
      end
      if !y_only.nil? && y_only.size > 0
        @errors << @finding.error("#{x.path}",'constraint.xpath','Additional constraints','',"#{y_constraints.map{|x|x.gsub(',',';')}.join(' && ')}")
      end

      # mustSupports
      if x.mustSupport != y.mustSupport
        @warnings << @finding.warning("#{x.path}",'mustSupport','Inconsistent mustSupport',"#{x.mustSupport || false}","#{y.mustSupport || false}")
      end

      # isModifier
      if x.isModifier != y.isModifier
        @errors << @finding.error("#{x.path}",'isModifier','Incompatible isModifier',"#{x.isModifier || false}","#{y.isModifier || false}")
      end
    end

    # -------------------------------------------------------------------------
    #                            Profile Validation
    # -------------------------------------------------------------------------

    # Checks whether or not the "resource" is valid according to this definition.
    # resource == object whose class inherits from FHIR::Resource, or XML, or JSON
    # representation == one of ['Resource','XML','JSON']
    def is_valid?(resource,representation='Resource')
      @errors = []
      @warnings = []
      if representation.downcase=='resource'
        if !is_fhir_class?(resource.class.to_s)
          @errors << "Not a FHIR Resource: #{resource.class.to_s}"
          return false
        end
        is_valid_xml? resource.to_xml
      elsif representation.downcase=='xml'
        is_valid_xml? resource
      elsif representation.downcase=='json'
        is_valid_json? resource
      else
        raise Exception.new "is_valid? unhandled representation: #{representation}"
      end
    end

    # Checks whether or not the "xml" is valid according to this definition.
    # xml == the raw xml for a FHIR resource
    def is_valid_xml?(xml)
      doc = Nokogiri::XML(xml)
      if doc.root.nil?
        @errors << "Not valid xml."
        return false
      end
      doc.root.add_namespace_definition('fhir', 'http://hl7.org/fhir')
      doc.root.add_namespace_definition('xhtml', 'http://www.w3.org/1999/xhtml')
      
      resource_type = doc.xpath('/*').first.name

      # Examine each element defined in the definition
      snapshot.element.each do |element|
        path = element.path
        is_attribute = element.representation.include? 'xmlAttr'

        if is_attribute
          path = path.sub(/(.*)(\.)(.*)/, '\1/@\3') 
        end
        if path.end_with?('[x]')
          path = path.gsub(name,"#{resource_type}").gsub('.','/')
          path = path.sub(/(.*)(\/)(fhir:)(.*)(\[x\])/,'\1\2*[starts-with(name(),\'\4\')]')
        else
          path = path.gsub(name,"fhir:#{resource_type}").gsub('.','/fhir:')
        end
        nodes = doc.xpath(path)
        nodes = doc.xpath(path.gsub('fhir:','')) if nodes.nil? || nodes.size==0

        # Check the cardinality
        min = element.min
        max = (element.max == '*') ? Float::INFINITY : element.max.to_i
        if (nodes.size < min) && (nodes.size > max)
          @errors << "#{element.path} failed cardinality test (#{min}..#{max}) -- found #{nodes.size}"
        end

        # Check the datatype for each node, only if the element has one declared
        if element.fhirType.size > 0
          nodes.each do |node|
            matching_type = 0
            if is_attribute
              value = node.value
            else
              value = node['value']
            end
            value = node.to_xml if value.nil? # probably an embedded resource like Narrative

            # the element is valid, if it matches at least one of the datatypes
            temp_messages = []
            element.fhirType.each do |type|
              data_type_code = type.code
              if is_data_type?(data_type_code,value,'XML')
                matching_type+=1 
                if data_type_code == 'code' # then check the binding
                  if(!element.binding.nil?)
                    matching_type+=check_binding(element,value)
                  end
                elsif data_type_code=='CodeableConcept' && element.pattern.try(:type)=='CodeableConcept' && !element.pattern.try(:value).nil?
                  # TODO check that the CodeableConcept matches the defined pattern
                  binding.pry
                elsif data_type_code=='String' && !element.maxLength.nil? && (value.size>element.maxLength)
                  @errors << "#{element.path} exceed maximum length of #{element.maxLength}: #{value}"
                end
              else
                temp_messages << "#{element.path} is not a valid #{data_type_code}: '#{value}'"
              end
            end
            if matching_type<=0
              @errors += temp_messages
              @errors << "#{element.path} did not match one of the valid data types: #{element.fhirType.map{|e|e.code}.to_s}"
            else
              @warnings += temp_messages
            end  
            if !element.fixed.nil? && element!=value
              @errors << "#{element.path} value of '#{value}' did not match fixed value: #{element.fixed}"
            end                     
          end
        end

        # check 'constraint.xpath' constraints
        if !element.constraint.empty?
          element.constraint.each do |constraint|
            nodes.each do |node|
              begin
                result = node.xpath(constraint.xpath)
                if !result
                  if constraint.severity=='error'
                    @errors << "#{element.path}: failed #{name} invariant rule #{constraint.key}: #{constraint.human}"
                  else
                    @warnings << "#{element.path}: failed #{name} invariant rule #{constraint.key}: #{constraint.human}"
                  end
                end
              rescue Exception => exp
                @warnings << "#{element.path}: invalid XPath 1.0 expression for #{name} invariant rule #{constraint.key}: #{constraint.human}"
              end
            end
          end
        end

      end

      @errors.size==0
    end

    # Checks whether or not the "json" is valid according to this definition.
    # json == the raw json for a FHIR resource
    def is_valid_json?(json)
      if json.is_a? String
        begin
          json = JSON.parse(json)
        rescue Exception => e
          @errors << "Failed to parse JSON: #{e.message} %n #{h} %n #{e.backtrace.join("\n")}"
          return false
        end
      end
      
      resource_type = json['resourceType']
      baseType = snapshot.element[0].path
      # if !resource_type.nil?
      #   fhir_class = get_fhir_class_from_resource_type(resource_type)
      #   if fhir_class.nil? or resource_type!=baseType
      #     @errors << "Invalid resourceType '#{resource_type}' or mismatch with '#{baseType}'"
      #     return false
      #   end
      # end

      snapshot.element.each do |element|
        path = element.path
        path = path[(baseType.size+1)..-1] if path.start_with? baseType
        nodes = get_json_nodes(json,path)

        # Check the cardinality
        min = element.min
        max = 
          if element.max == '*'
            Float::INFINITY
          else 
            element.max.to_i
          end
        if (nodes.size < min) && (nodes.size > max)
          @errors << "#{element.path} failed cardinality test (#{min}..#{max}) -- found #{nodes.size}"
        end

        # Check the datatype for each node, only if the element has one declared, and it isn't the root element
        if element.fhirType.size > 0 && element.path!=xmlId
          nodes.each do |value|
            matching_type = 0

            # the element is valid, if it matches at least one of the datatypes
            temp_messages = []
            element.fhirType.each do |type|
              data_type_code = type.code
              if is_data_type?(data_type_code,value,'JSON')
                matching_type+=1 
                if data_type_code == 'code' # then check the binding
                  if(!element.binding.nil?)
                    matching_type+=check_binding(element,value)
                  end
                elsif data_type_code=='CodeableConcept' && element.pattern.try(:type)=='CodeableConcept' && !element.pattern.try(:value).nil?
                  # TODO check that the CodeableConcept matches the defined pattern
                  binding.pry
                elsif data_type_code=='String' && !element.maxLength.nil? && (value.size>element.maxLength)
                  @errors << "#{element.path} exceed maximum length of #{element.maxLength}: #{value}"
                end
              else
                temp_messages << "#{element.path} is not a valid #{data_type_code}: '#{value}'"
              end
            end
            if matching_type<=0
              @errors += temp_messages
              @errors << "#{element.path} did not match one of the valid data types: #{element.fhirType.map{|e|e.code}.to_s}"
            else
              @warnings += temp_messages
            end
            if !element.fixed.nil? && element!=value
              @errors << "#{element.path} value of '#{value}' did not match fixed value: #{element.fixed}"
            end
          end
       end

        # check 'constraint.xpath' constraints
        if !element.constraint.empty?
          element.constraint.each do |constraint|
            @warnings << "#{element.path}: unable to evaluate XPath expression against JSON for #{name} invariant rule #{constraint.key}: #{constraint.human}"
          end
        end

      end

      @errors.size==0
    end

    def get_json_nodes(json,path)
      results = []
      return [json] if path.nil?
      steps = path.split('.')
      steps.each.with_index do |step,index|
        if json.is_a? Hash
          json = json[step]
        elsif json.is_a? Array
          json.each do |e|
            results << get_json_nodes(e,steps[index..-1].join('.'))
            return results.flatten!
          end
        else 
          # this thing doesn't exist
          return results
        end
        return results if json.nil?
      end

      if !json.is_a? Array
        results << json
      else
        results = json
      end
      results
    end

    # data_type_code == a FHIR DataType code (see http://hl7.org/fhir/2015May/datatypes.html)
    # value == the representation of the value
    # representation == one of ['Resource','XML','JSON']
    def is_data_type?(data_type_code,value,representation='Resource')      
      # FHIR models covers any base Resources
      if is_fhir_class? "FHIR::#{data_type_code}"
        definition = FHIR::StructureDefinition.get_base_definition(data_type_code)
        if !definition.nil?
          retVal = definition.is_valid?(value,representation)
          if !retVal
            @errors += definition.errors 
            @warnings += definition.warnings
          end
          return retVal
        end
      end

      # Remaining data types: handle special cases before checking type StructureDefinitions
      return case data_type_code.downcase
      when 'domainresource'
        true # we don't have to verify domain resource, because it will be included in the snapshot
      when 'boolean'
        value==true || value==false || value.downcase=='true' || value.downcase=='false'
      when 'code'
        value.is_a?(String) && value.size>=1 && value.size==value.rstrip.size
      when 'string', 'markdown'
        value.is_a?(String)
      when 'xhtml'
        fragment = Nokogiri::HTML::DocumentFragment.parse(value)
        value.is_a?(String) && fragment.errors.size == 0
      when 'base64binary'
        regex = /[^0-9\+\/\=A-Za-z\r\n ]/ 
        value.is_a?(String) && (regex =~ value).nil?
      when 'id'
        regex = /[^\d\w\-\.]/
        # the FHIR spec says IDs have a length limit of 36 characters. But it also says that OIDs
        # are valid IDs, and ISO OIDs have no length limitations.
        value.is_a?(String) && (regex =~ value).nil? # && value.size<=36 
      when 'oid'
        regex = /[^(urn:oid:)[\d\.]]/
        value.is_a?(String) && (regex =~ value).nil?       
      when 'uri'
        is_valid_uri = false
        begin
          is_valid_uri = !URI.parse(value).nil?
        rescue Exception
          is_valid_uri = false
        end
        is_valid_uri
      when 'instant'
        regex = /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/
        value.is_a?(String) && !(regex =~ value).nil?
      when 'date'
        regex = /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/
        value.is_a?(String) && !(regex =~ value).nil?        
      when 'datetime'
        regex = /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/
        value.is_a?(String) && !(regex =~ value).nil?
      when 'time'
        regex = /\A([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?\Z/
        value.is_a?(String) && !(regex =~ value).nil?
      when 'integer','unsignedint'
        (!Integer(value).nil? rescue false)
      when 'positiveint'
        (!Integer(value).nil? rescue false) && (Integer(value) >= 0)     
      when 'decimal'
        (!Float(value).nil? rescue false)
      when 'resource'
        if representation.downcase == 'xml'
          doc = Nokogiri::XML(value)
          contained_resources_valid = true
          doc.root.element_children do |element|
            element.add_namespace_definition(nil,'http://hl7.org/fhir')
            contained_resources_valid = contained_resources_valid && is_valid_xml?(element.to_xml)
          end
          contained_resources_valid
        elsif representation.downcase == 'json'
          resource_type = value['resourceType']
          definition = FHIR::StructureDefinition.get_base_definition(resource_type)
          if !definition.nil?
            retVal = definition.is_valid?(value,representation)
            if !retVal
              @errors += definition.errors 
              @warnings += definition.warnings
            end
            retVal
          else
            @errors << "Unable to find base type definition: #{resource_type}"
            false
          end
        else
          raise Exception.new "is_data_type? unhandled 'resource' DataType with 'resource' representation."
        end
      else
        # Eliminate endless loop on Element is an Element
        return true if (data_type_code=='Element' && xmlId=='Element') 

        definition = FHIR::StructureDefinition.get_type_definition(data_type_code)
        definition = FHIR::StructureDefinition.get_base_definition(data_type_code) if definition.nil?
        if !definition.nil?
          retVal = definition.is_valid?(value,representation)
          if !retVal
            @errors += definition.errors 
            @warnings += definition.warnings
          end
          retVal
        else
          @errors << "Unable to find base type definition: #{data_type_code}"
          false
        end
      end
    end

    def check_binding(element,value)

      vsUri = element.binding.valueSetUri || element.binding.try(:valueSetReference).try(:reference)
      valueset = FHIR::ValueSet.get_base_valueset(vsUri)

      matching_type = 0

      if vsUri=='http://hl7.org/fhir/ValueSet/content-type' || vsUri=='http://www.rfc-editor.org/bcp/bcp13.txt'
        matches = MIME::Types[value]
        if (matches.nil? || matches.size==0) && !is_some_type_of_xml_or_json(value)
          @errors << "#{element.path} has invalid mime-type: '#{value}'"
          matching_type-=1 if element.binding.strength=='required'
        end
      elsif vsUri=='http://tools.ietf.org/html/bcp47' 
        hasRegion = (!(value =~ /-/).nil?)
        valid = !BCP47::Language.identify(value).nil? && (!hasRegion || !BCP47::Region.identify(value).nil?)
        if !valid
          @errors << "#{element.path} has unrecognized language: '#{value}'"
          matching_type-=1 if element.binding.strength=='required'            
        end
      elsif valueset.nil?
        @errors << "#{element.path} has unknown ValueSet: '#{vsUri}'"
        matching_type-=1 if element.binding.strength=='required'
      elsif !valueset.include?(value)
        message = "#{element.path} has invalid code '#{value}' from '#{element.short}'"
        if element.binding.strength=='required'
          @errors << message
          matching_type-=1
        else
          @warnings << message
        end
      end

      matching_type
    end

    def is_some_type_of_xml_or_json(code)
      m = code.downcase
      return true if m=='xml' || m=='json'
      return true if (m.starts_with?('application/') || m.starts_with?('text/')) && (m.ends_with?('json') || m.ends_with?('xml'))
      return true if (m.starts_with?('application/xml') || m.starts_with?('text/xml'))
      return true if (m.starts_with?('application/json') || m.starts_with?('text/json'))
      false
    end

  private :is_valid_xml?, :is_valid_json?, :get_json_nodes, :is_data_type?, :check_binding, :add_missing_elements, :compare_element_definitions

  end
end

