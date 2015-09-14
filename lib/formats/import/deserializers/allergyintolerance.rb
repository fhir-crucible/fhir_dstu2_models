module FHIR
    module Deserializer
        module AllergyIntolerance
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_AllergyIntoleranceReactionComponent(entry) 
                return nil unless entry
                model = FHIR::AllergyIntolerance::AllergyIntoleranceReactionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'substance', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:substance')))
                parse_primitive_field(model,entry,'certainty','certainty',false)
                set_model_data(model, 'manifestation', entry.xpath('./fhir:manifestation').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'onset','onset',false)
                parse_primitive_field(model,entry,'severity','severity',false)
                set_model_data(model, 'exposureRoute', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:exposureRoute')))
                set_model_data(model, 'note', FHIR::Annotation.parse_xml_entry(entry.at_xpath('./fhir:note')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'onset','onset',false)
                parse_primitive_field(model,entry,'recordedDate','recordedDate',false)
                set_model_data(model, 'recorder', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:recorder')))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'reporter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reporter')))
                set_model_data(model, 'substance', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:substance')))
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'criticality','criticality',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'category','category',false)
                parse_primitive_field(model,entry,'lastOccurence','lastOccurence',false)
                set_model_data(model, 'note', FHIR::Annotation.parse_xml_entry(entry.at_xpath('./fhir:note')))
                set_model_data(model, 'reaction', entry.xpath('./fhir:reaction').map {|e| parse_xml_entry_AllergyIntoleranceReactionComponent(e)})
                model
            end
        end
    end
end
