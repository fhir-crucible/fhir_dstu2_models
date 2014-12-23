module FHIR
  module Export
    class ModelSerializer
      DEFAULTS={
        is_root: true,
        is_lowercase: false
      }
      def initialize
        template_helper = TemplateHelper.new
        @rendering_context = RenderingContext.new
        @rendering_context.template_helper = template_helper
      end

      def serialize(model, options={})
        options = DEFAULTS.merge(options)
        options[:model] = model
        @rendering_context.render(:template => model.class.name.demodulize.downcase, :locals => options).gsub /^\s*$\n/, ''
      end      
    end
  end
end
