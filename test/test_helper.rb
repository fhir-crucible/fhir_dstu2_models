require_relative "./simplecov"
require_relative '../lib/fhir_model'

require 'pry'
require 'minitest/autorun'
require 'bundler/setup'
require 'test/unit'
require 'turn'

EXCLUDED_RESOURCES = ['Account','Claim','Coverage','feed','GeneExpression','GeneticAnalysis','GVFMeta',
             'GVFVariant','HealthcareService','Microarray','Person','Protocol',
             'Remittance','Resource','SecurityClaim','SecurityGroup','SecurityPrincipal',
             'Sequence','SequencingAnalysis','SequencingLab','Test','User','VCFMeta','VCFVariant']
