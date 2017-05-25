require 'simplecov'
SimpleCov.start

require 'objspace'
require 'nokogiri/diff'
require 'test/unit'
require 'pry'

require 'fhir_dstu2_models'
FHIR::DSTU2.logger.level = Logger::INFO


TESTMEMORY = (ENV['TESTMEMORY'] || 0).to_i
puts "***** TESTMEMORY: #{TESTMEMORY} *****"
GCDELAY = (ENV['GCDELAY'] || 0.1).to_f
puts "***** GCDELAY: #{GCDELAY} *****"

def check_memory
  memory = Hash.new(0)
  return memory if TESTMEMORY==0
  ObjectSpace.each_object(FHIR::DSTU2::Model) {|x| memory[x.class.to_s] += 1}
  memory
end

def wait_for_gc
  return if TESTMEMORY==0
  # The Ruby garbage collector is asynchronous and has no callback features,
  # so you don't know when it is finished. We'll call it twice with a short sleep
  # in hopes that it is completed.
  count = GC.count
  while(GC.count <= count+1) do
    ObjectSpace.garbage_collect
    sleep GCDELAY
  end
end

def assert_memory(before,after)
  return if TESTMEMORY==0
  unless after.empty?
    puts "BEFORE GC: #{before}"
    puts "AFTER GC: #{after}"
  end
  assert after.empty?, 'Garbage collection missed FHIR::DSTU2 Models.'
end

def compare(hash_input, hash_output)
  return [hash_input] if hash_output.nil?

  # ignore fhir comments -- we don't support them.
  strip_out_unsupported!(hash_input)
  strip_out_unsupported!(hash_output)

  errors = []

  added = hash_output.keys - hash_input.keys
  errors << "Added extra fields: #{added.join(', ')}" unless added.empty?

  dropped = hash_input.keys - hash_output.keys
  errors << "Dropped fields: #{dropped.join(', ')}" unless dropped.empty?

  shared_keys = hash_input.keys - dropped
  shared_keys.each do |key|
    input = hash_input[key]
    output = hash_output[key]
    if input.is_a?(Array) && !output.is_a?(Array)
      errors << "#{key}:\n - INPUT:  #{input}\n - OUTPUT: #{output}"
      next
    end
    if output.is_a?(Array) && !input.is_a?(Array)
      errors << "#{key}:\n - INPUT:  #{input}\n - OUTPUT: #{output}"
      next
    end
    if input.is_a?(Array)
      input.each_with_index do |item, index|
        item_b = output[index]
        if item.is_a?(Hash)
          errors += compare(item, item_b)
        elsif input != output
          errors << "#{key}[#{index}]: #{input} != #{output}"
        end
      end
      errors << "#{key}:\n - INPUT:  #{input}\n - OUTPUT: #{output}" if input.size != output.size
    elsif input.is_a?(Hash)
      errors += compare(input, output)
    elsif is_a_date_or_time(input) || is_a_date_or_time(output)
    # ignore date time formatting
    elsif input.is_a?(String) && output.is_a?(String)
      left = input.gsub(/[[:space:]]/, '')
      right = output.gsub(/[[:space:]]/, '')
      errors << "#{key}:\n - INPUT:  #{left}\n - OUTPUT: #{right}" if left != right
    elsif input != output
      errors << "#{key}:\n - INPUT:  #{input}\n - OUTPUT: #{output}"
    end
  end
  errors
end

# This method removes fhir_comments and primitive extensions
# from the hash... we don't support them.
def strip_out_unsupported!(hash)
  hash.each do |key, value|
    delete_key = false
    # delete fhir_comments and primitive extensions
    if key == 'fhir_comments' || key.start_with?('_')
      delete_key = true
    elsif value.is_a?(Array)
      value.each do |thing|
        strip_out_unsupported!(thing) if thing.is_a?(Hash)
      end
    elsif value.is_a?(Hash)
      strip_out_unsupported!(value)
      delete_key = value.empty?
    end
    hash.delete(key) if delete_key
  end
end

def is_a_date_or_time(value)
  return false unless value.is_a?(String)

  %w(date dateTime time).each do |type|
    meta = FHIR::DSTU2::PRIMITIVES[type]
    expression = meta['regex']
    regex = Regexp.new(expression)
    return true unless (regex =~ value).nil?
  end

  # when 'instant'
  regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))/
  return true unless (regex =~ value).nil?

  false

  # # when 'instant'
  # regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))/
  # return true if !(regex =~ value).nil?
  # # when 'date'
  # regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])))/
  # return true if !(regex =~ value).nil?
  # # when 'datetime'
  # regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?/
  # return true if !(regex =~ value).nil?
  # # when 'time'
  # regex = /([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?/
  # return true if !(regex =~ value).nil?
  # false
end