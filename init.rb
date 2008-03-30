ActionView::Base.field_error_proc = Proc.new{ |input_or_label, instance| "<span class=\"form_error\">#{input_or_label}</span>" }
ActionView::Base.send :include, LabeledFormWithErrorsHelper
