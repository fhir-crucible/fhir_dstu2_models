module FHIR
  module Export
    # Class that finds ERb templates. Here is how it can be configured:
    class TemplateHelper
      def initialize()
        @template_cache = {}
        @template_format = 'xml'
      end

      def template_root
        @template_directory ||= File.join(File.dirname(__FILE__), 'templates')
        @template_directory
      end

      # Returns the raw ERb for the template_name provided. This method will look in
      # template_directory/template_subdir/template_name.template_format.erb
      def template(template_name)
        cache_template(template_name)
      end

      # Basically the same template, but prepends an underscore to the template name
      # to mimic the Rails convention for template fragments
      def partial(partial_name)
        cache_template("_#{partial_name}")
      end

      protected 

      def cache_template(template_name)
        entry = @template_cache[template_name] || {mtime:-1, erb:nil}
        filename = File.join(template_root, "#{template_name}.#{@template_format}.erb")
        mtime = File.mtime(filename).to_i
        if mtime > entry[:mtime]
          src = File.read(filename)
          erb = Erubis::EscapedEruby.new(src)
          erb.filename=filename
          entry[:mtime]=mtime
          entry[:erb] = erb
          @template_cache[template_name]=entry
        end
        entry[:erb]
      end
    end
  end
end