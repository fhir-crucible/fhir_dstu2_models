module FHIR
  class ValueSet

    @@base_valuesets = nil

    def self.load_valuesets
      if @@base_valuesets.nil?
        filename = File.join(File.dirname(__FILE__),'valuesets.xml')
        xml = File.read(filename)
        @@base_valuesets = FHIR::Bundle.from_xml(xml)
      end
    end

    def self.get_base_valueset(valueset_name)
      return nil if valueset_name.nil?
      load_valuesets

      @@base_valuesets.entry.each do |entry|
        if entry.resourceType == 'ValueSet'
          if !entry.resource.nil? && (entry.resource.identifier == valueset_name || entry.resource.name == valueset_name || entry.resource.xmlId == valueset_name)
            return entry.resource
          end
        end
      end

      nil
    end

    def include?(code)
      # first, check defines
      if !define.nil?
        define.concept.each do |concept|
          return true if concept_include?(concept,code)
        end
      end

      # if it wasn't found, need to check compose
      if !compose.nil?
        return true if((compose_import?(compose,code) || compose_include?(compose,code)) && !compose_exclude?(compose,code))
      end

      # finally, try checking expansion
      if !expansion.nil?
        return expansion_include?(code)
      end

      false
    end

    def concept_include?(concept, code)
      return false if (concept.nil? || code.nil?)
      return true if concept.code==code
      return true if (define.caseSensitive==false && concept.code.downcase==code.downcase)
      if !concept.concept.nil?
        concept.concept.each do |child|
          return true if concept_include?(child,code)
        end
      end
      false
    end

    # TODO compose_import? won't fetch remote ValueSets
    def compose_import?(compose, code)
     return false if (compose.nil? || compose.import.nil? || code.nil?)
      compose.import.each do |import|
        other = FHIR::ValueSet.get_base_valueset(import)
        return true if !other.nil? && other.include?(code)
      end
      false      
    end

    def compose_include?(compose, code)
      return false if (compose.nil? || compose.include.nil? || code.nil?)
      compose.include.each do |concept|
        concept.concept.each do |c|
          return true if c.code==code
          return true if (!define.nil? && define.caseSensitive==false && c.code.downcase==code.downcase)
        end
      end
      false
    end

    def compose_exclude?(compose, code)
      return false if (compose.nil? || compose.exclude.nil? || code.nil?)
      compose.exclude.each do |concept|
        concept.concept.each do |c|
          return true if c.code==code
          return true if (!define.nil? && define.caseSensitive==false && c.code.downcase==code.downcase)
        end
      end
      false
    end

    def expansion_include?(code)
      return false if (expansion.nil? || code.nil?)
      expansion.contains.each do |contains|
        return true if contains_include?(contains,code)
      end
      false
    end

    def contains_include?(contains,code)
      return false if (contains.nil? || code.nil?)
      return true if contains.code==code
      return true if (!define.nil? && define.caseSensitive==false && !contains.code.nil? && contains.code.downcase==code.downcase)
      if !contains.contains.nil?
        contains.contains.each do |c|
          return true if contains_include?(c,code)
        end
      end
      false
    end

    private :concept_include?, :compose_import?, :compose_include?, :compose_exclude?, :expansion_include?, :contains_include?

  end
end
