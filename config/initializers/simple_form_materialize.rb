require 'button_components'

# Use this setup block to configure all options available in SimpleForm.
# Based on simple form bootstrap
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'waves-effect waves-light btn right'
  config.boolean_label_class = nil

  config.wrappers :vertical_form, tag: 'div', class: 'input-field col s12', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: ''

    b.use :input, class: ''
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :checkbox_input, tag: 'div', class: 'input-field col s12', error_class: 'has-error' do |b|
    b.use :html5

    b.use :input
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
    checkbox_materialize: :checkbox_input,
  }

end
