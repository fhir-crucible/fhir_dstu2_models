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
    class Specimen 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Specimen
        
        SEARCH_PARAMS = [
            'container',
            'identifier',
            'parent',
            'container-id',
            'bodysite',
            'subject',
            'patient',
            'collected',
            'accession',
            'type',
            'collector'
        ]
        
        VALID_CODES = {
            fhirType: [ '...', 'ABS', 'ACNE', 'ACNFLD', 'AIRS', 'ALL', 'AMN', 'AMP', 'ANGI', 'ARTC', 'ASERU', 'ASP', 'ATTE', 'AUTOA', 'AUTOC', 'AUTP', 'BBL', 'BCYST', 'BDY', 'BIFL', 'BITE', 'BLD', 'BLDA', 'BLDCO', 'BLDV', 'BLEB', 'BLIST', 'BOIL', 'BON', 'BONE', 'BOWL', 'BPH', 'BPU', 'BRN', 'BRSH', 'BRTH', 'BRUS', 'BUB', 'BULLA', 'BX', 'CALC', 'CARBU', 'CAT', 'CBITE', 'CDM', 'CLIPP', 'CNJT', 'CNL', 'COL', 'CONE', 'CSCR', 'CSERU', 'CSF', 'CSITE', 'CSMY', 'CST', 'CSVR', 'CTP', 'CUR', 'CVM', 'CVPS', 'CVPT', 'CYN', 'CYST', 'DBITE', 'DCS', 'DEC', 'DEION', 'DIA', 'DIAF', 'DISCHG', 'DIV', 'DRN', 'DRNG', 'DRNGP', 'DUFL', 'EARW', 'EBRUSH', 'EEYE', 'EFF', 'EFFUS', 'EFOD', 'EISO', 'ELT', 'ENVIR', 'EOS', 'EOTH', 'ESOI', 'ESOS', 'ETA', 'ETTP', 'ETTUB', 'EWHI', 'EXG', 'EXS', 'EXUDTE', 'FAW', 'FBLOOD', 'FGA', 'FIB', 'FIST', 'FLD', 'FLT', 'FLU', 'FLUID', 'FOLEY', 'FRS', 'FSCLP', 'FUR', 'GAS', 'GASA', 'GASAN', 'GASBR', 'GASD', 'GAST', 'GENL', 'GENV', 'GRAFT', 'GRAFTS', 'GRANU', 'GROSH', 'GSOL', 'GSPEC', 'GT', 'GTUBE', 'HAR', 'HBITE', 'HBLUD', 'HEMAQ', 'HEMO', 'HERNI', 'HEV', 'HIC', 'HYDC', 'IBITE', 'ICYST', 'IDC', 'IHG', 'ILEO', 'ILLEG', 'IMP', 'INCI', 'INFIL', 'INS', 'INTRD', 'ISLT', 'IT', 'IUD', 'IVCAT', 'IVFLD', 'IVTIP', 'JEJU', 'JNTFLD', 'JP', 'KELOI', 'KIDFLD', 'LAVG', 'LAVGG', 'LAVGP', 'LAVPG', 'LENS1', 'LENS2', 'LESN', 'LIQ', 'LIQO', 'LNA', 'LNV', 'LSAC', 'LYM', 'MAC', 'MAHUR', 'MAR', 'MASS', 'MBLD', 'MEC', 'MILK', 'MLK', 'MUCOS', 'MUCUS', 'NAIL', 'NASDR', 'NEDL', 'NEPH', 'NGASP', 'NGAST', 'NGS', 'NODUL', 'NSECR', 'ORH', 'ORL', 'OTH', 'PACEM', 'PAFL', 'PCFL', 'PDSIT', 'PDTS', 'PELVA', 'PENIL', 'PERIA', 'PILOC', 'PINS', 'PIS', 'PLAN', 'PLAS', 'PLB', 'PLC', 'PLEVS', 'PLR', 'PMN', 'PND', 'POL', 'POPGS', 'POPLG', 'POPLV', 'PORTA', 'PPP', 'PROST', 'PRP', 'PSC', 'PUNCT', 'PUS', 'PUSFR', 'PUST', 'QC3', 'RANDU', 'RBC', 'RBITE', 'RECT', 'RECTA', 'RENALC', 'RENC', 'RES', 'SAL', 'SCAR', 'SCLV', 'SCROA', 'SECRE', 'SER', 'SHU', 'SHUNF', 'SHUNT', 'SITE', 'SKBP', 'SKN', 'SMM', 'SMN', 'SNV', 'SPRM', 'SPRP', 'SPRPB', 'SPS', 'SPT', 'SPTC', 'SPTT', 'SPUT1', 'SPUTIN', 'SPUTSP', 'STER', 'STL', 'STONE', 'SUBMA', 'SUBMX', 'SUMP', 'SUP', 'SUTUR', 'SWGZ', 'SWT', 'TASP', 'TEAR', 'THRB', 'TISS', 'TISU', 'TLC', 'TRAC', 'TRANS', 'TSERU', 'TSTES', 'TTRA', 'TUBES', 'TUMOR', 'TZANC', 'UDENT', 'UMED', 'UR', 'URC', 'URINB', 'URINC', 'URINM', 'URINN', 'URINP', 'URNS', 'URT', 'USCOP', 'USPEC', 'USUB', 'VASTIP', 'VENT', 'VITF', 'VOM', 'WASH', 'WASI', 'WAT', 'WB', 'WBC', 'WEN', 'WICK', 'WND', 'WNDA', 'WNDD', 'WNDE', 'WORM', 'WRT', 'WWA', 'WWO', 'WWT' ],
            status: [ 'available', 'unavailable', 'unsatisfactory', 'entered-in-error' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec fhirCollection
        class SpecimenCollectionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                method: [ '119295008', '413651001', '360020006', '430823004', '16404004', '67889009', '29240004', '45710003', '7800008', '258431006', '20255002', '386147002', '278450005', 'ANP', 'BAP', 'BCAE', 'BCAN', 'BCPD', 'BIO', 'CAP', 'CATH', 'CVP', 'EPLA', 'ESWA', 'FNA', 'KOFFP', 'LNA', 'LNV', 'MARTL', 'ML11', 'MLP', 'NYP', 'PACE', 'PIN', 'PNA', 'PRIME', 'PUMP', 'QC5', 'SCLP', 'SCRAPS', 'SHA', 'SWA', 'SWD', 'TMAN', 'TMCH', 'TMM4', 'TMMY', 'TMOT', 'TMP', 'TMPV', 'TMSC', 'TMUP', 'TMVI', 'VENIP', 'WOOD' ]
            }
            
            MULTIPLE_TYPES = {
                collected: [ 'collectedDateTime', 'collectedPeriod' ]
            }
            
            embeds_one :collector, class_name:'FHIR::Reference'
            field :comment, type: Array # Array of Strings
            field :collectedDateTime, type: String
            validates :collectedDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
            embeds_one :collectedPeriod, class_name:'FHIR::Period'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :method, class_name:'FHIR::CodeableConcept'
            embeds_one :bodySite, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec treatment
        class SpecimenTreatmentComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                procedure: [ 'ACID', 'ALK', 'DEFB', 'FILT', 'LDLP', 'NEUT', 'RECA', 'UFIL' ]
            }
            
            field :description, type: String
            embeds_one :procedure, class_name:'FHIR::CodeableConcept'
            embeds_many :additive, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec container
        class SpecimenContainerComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                additiveCodeableConcept: [ 'ACDA', 'ACDB', 'ACET', 'AMIES', 'BACTM', 'BF10', 'BOR', 'BOUIN', 'BSKM', 'C32', 'C38', 'CARS', 'CARY', 'CHLTM', 'CTAD', 'EDTK', 'EDTK15', 'EDTK75', 'EDTN', 'ENT', 'ENT+', 'F10', 'FDP', 'FL10', 'FL100', 'HCL6', 'HEPA', 'HEPL', 'HEPN', 'HNO3', 'JKM', 'KARN', 'KOX', 'LIA', 'M4', 'M4RT', 'M5', 'MICHTM', 'MMDTM', 'NAF', 'NAPS', 'NONE', 'PAGE', 'PHENOL', 'PVA', 'RLM', 'SILICA', 'SPS', 'SST', 'STUTM', 'THROM', 'THYMOL', 'THYO', 'TOLU', 'URETM', 'VIRTM', 'WEST' ]
            }
            
            MULTIPLE_TYPES = {
                additive: [ 'additiveCodeableConcept', 'additiveReference' ]
            }
            
            embeds_many :identifier, class_name:'FHIR::Identifier'
            field :description, type: String
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            embeds_one :capacity, class_name:'FHIR::Quantity'
            embeds_one :specimenQuantity, class_name:'FHIR::Quantity'
            embeds_one :additiveCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :additiveReference, class_name:'FHIR::Reference'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        embeds_many :parent, class_name:'FHIR::Reference'
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_one :accessionIdentifier, class_name:'FHIR::Identifier'
        field :receivedTime, type: String
        validates :receivedTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :fhirCollection, class_name:'FHIR::Specimen::SpecimenCollectionComponent'
        embeds_many :treatment, class_name:'FHIR::Specimen::SpecimenTreatmentComponent'
        embeds_many :container, class_name:'FHIR::Specimen::SpecimenContainerComponent'
        track_history
    end
end
