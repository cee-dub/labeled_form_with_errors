# LabeledFormWithErrorsHelper enhances the built-in form builders
# by adding messages and styles to fields with validation errors.
module LabeledFormWithErrorsHelper
  
  # Each of these methods will use the LabeledFormWithErrorsBuilder
  %w(form_for fields_for form_remote_for remote_form_for).each do |method_name|
    src = <<-end_src
      def labeled_#{method_name}(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.merge! :builder => LabeledFormWithErrorsBuilder
        #{method_name}(object_name, *(args << options), &proc)
      end
    end_src
    module_eval src, __FILE__, __LINE__
  end
  
  # the custom form builder
  class LabeledFormWithErrorsBuilder < ::ActionView::Helpers::FormBuilder
    # Maintains the semantics of FormBuilder#label
    # Can be called with an optional alternate label to use
    # +label(method_name, options={})+ #=> uses +method_name.humanize+
    # +label(method_name, custom_label, options={})+ #=> uses the +custom_label+
    def label(method, *args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      name = args.pop || method.to_s.humanize
      label_text = @object.errors.on(method).blank? ? name : "#{name} <span>#{@object.errors.on(method).to_a.to_sentence}</span>"
      super(method, label_text, options.merge(:object => @object))
    end
  end
end
