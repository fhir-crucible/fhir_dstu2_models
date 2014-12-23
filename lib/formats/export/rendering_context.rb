module FHIR
  module Export

    # Used to actually render stuff. A RenderingContext needs to be set up with
    # a template helper and may be provided with extensions.
    #
    # :call-seq:
    #   template_helper = FHIR::Export::TemplateHelper.new
    #   rendering_context = FHIR::Export::RenderingContext.new
    #   rendering_context.template_helper = template_helper
    #   rendering_context.extensions = [FHIR::Export::Helper::XMLTemplateHelper]
    #
    class RenderingContext < OpenStruct
      attr_accessor :template_helper, :extensions

      def my_binding
        binding
      end

      def render(params)
        erb = nil
        ident = nil
        if params[:template]
          erb = @template_helper.template(params[:template])
        elsif params[:partial]
          erb = @template_helper.partial(params[:partial])
          if params[:collection] 
            ident = params[:id] || params[:partial]
          end
        end

        collection = params[:collection] || [true]
        collection.map do |item| 
          locals = params[:locals]
          locals ||= {}
          if ident
            locals[ident] = item 
          end
          rendering_context = RenderingContext.new(locals)
          rendering_context.template_helper = @template_helper
          if @extensions.present?
            rendering_context.extensions = @extensions
            @extensions.each do |extension|
              rendering_context.extend(extension)
            end
          end
          erb.result(rendering_context.my_binding)
        end.join
      end
    end
  end
end
