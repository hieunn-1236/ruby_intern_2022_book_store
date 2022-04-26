module Admin::FormHelper
  def errors_for form, fields, full_error_message: true, object: false
    object = object ? form : form.object
    message = if full_error_message
                object.errors
                      .full_messages_for(fields)
                      .join ", "
              else
                object.errors.message
                [fields].join ", "
              end
    content_tag :p, message, class: "text-danger #{fields}-error"
  end
end
