# Top level include file that brings in all the necessary code
require 'bundler/setup'
require 'rubygems'
require 'yaml'
require 'mongoid'
require 'erubis'
require 'nokogiri'
require 'mongoid-history'
require 'date_time_precision'
require 'date_time_precision/format/iso8601'

Moped::BSON = BSON

#require_relative File.join('..','lib','formats','import','utilities.rb')

root = File.expand_path '..', File.dirname(File.absolute_path(__FILE__))

Dir.glob(File.join(root, 'lib','formats','*.rb')).each do |file|
  require file
end

Dir.glob(File.join(root, 'lib','formats','import','*.rb')).each do |file|
  require file
end

Dir.glob(File.join(root, 'lib','formats','import','**','*.rb')).each do |file|
  require file
end

Dir.glob(File.join(root, 'lib','formats','export','*.rb')).each do |file|
  require file
end

Dir.glob(File.join(root, 'lib','formats','export','**','*.rb')).each do |file|
  require file
end

require_relative File.join(root, 'lib','models','any_type.rb')
require_relative File.join(root, 'lib','models','history_tracker.rb')
require_relative File.join(root, 'lib','models','partial_date_time.rb')
require_relative File.join(root, 'lib','models','extensions','element.rb')
require_relative File.join(root, 'lib','models','extensions','resource.rb')
Dir.glob(File.join(root, 'lib','models','**','*.rb')).each do |file|
  require file
end
require_relative File.join('..','config','initializers','mongoid_history.rb')
require_relative File.join('..','config','initializers','mongo.rb')
