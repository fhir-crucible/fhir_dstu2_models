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
  class StructureDefinitionFinding
    # This is not an official FHIR Resource type. It is a data structure used for reporting.
    attr_accessor :resourceType
    attr_accessor :profileIdA
    attr_accessor :profileIdB
    attr_accessor :status
    attr_accessor :path
    attr_accessor :attribute
    attr_accessor :message
    attr_accessor :valueA
    attr_accessor :valueB

    def to_s
      "#{resourceType},#{profileIdA},#{profileIdB},#{path},#{attribute},#{status},#{message},#{valueA},#{valueB}"
    end

    def to_json
      JSON.pretty_unparse(as_json)
    end

    def from_json(json)
      obj = FHIR::StructureDefinitionFinding.new
      if json.is_a? String
        begin
          if json.encoding.names.include? 'UTF-8'
            json.gsub!("\xEF\xBB\xBF".force_encoding('UTF-8'), '') # remove UTF-8 BOM
          end
          hash = JSON.parse(json)
          hash.each do |key,value|
            obj.send("#{key}=".to_sym,value) if value
          end
        rescue Exception => e
          puts "Failed to parse JSON: #{e.message}"
          return nil
        end
      end
      obj
    end

    def clone
      from_json(to_json)
    end

    def warning(path,attribute,message,valueA,valueB)
      obj = clone
      obj.status = 'WARNING'
      obj.path = path
      obj.attribute = attribute
      obj.message = message
      obj.valueA = valueA
      obj.valueB = valueB
      obj
    end

    def error(path,attribute,message,valueA,valueB)
      obj = clone
      obj.status = 'ERROR'
      obj.path = path
      obj.attribute = attribute
      obj.message = message
      obj.valueA = valueA
      obj.valueB = valueB
      obj
    end

  end
end
