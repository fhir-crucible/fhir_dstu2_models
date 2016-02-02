module FHIR
  module Formats
    class XPathFunctions

      #
      # Implements the exists XPath 2 function.
      #
      def self.exists(node_set)
        notnil = !node_set.nil?
        isarray = node_set.is_a?(Nokogiri::XML::NodeSet)
        notarray = !isarray
        nonempty = !node_set.empty? if isarray
        notnil && (notarray || (isarray && nonempty))
      end

      def self.dateTime_greater_than(node_set_a, node_set_b)
        high = nil
        low = nil
        begin
          high = node_set_a.map{|x|DateTime.parse(x.value)} if !node_set_a.nil? && node_set_a.is_a?(Nokogiri::XML::NodeSet)
          low = node_set_b.map{|x|DateTime.parse(x.value)} if !node_set_b.nil? && node_set_b.is_a?(Nokogiri::XML::NodeSet)
        rescue
          # failed
        end
        if !high.nil? && !low.nil?
          (high.first >= low.first)
        else
          false
        end
      end

      def self.dateTime_less_than(node_set_a, node_set_b)
        high = nil
        low = nil
        begin
          low = node_set_a.map{|x|DateTime.parse(x.value)} if !node_set_a.nil? && node_set_a.is_a?(Nokogiri::XML::NodeSet)
          high = node_set_b.map{|x|DateTime.parse(x.value)} if !node_set_b.nil? && node_set_b.is_a?(Nokogiri::XML::NodeSet)
        rescue
          # failed
        end
        if !high.nil? && !low.nil?
          (high.first >= low.first)
        else
          false
        end
      end

      def self.current(args)
        return args
      end

    end
  end
end
