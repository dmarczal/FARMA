# https://gist.github.com/maxivak/57a2fb71afeb9efcf771
module ButtonComponents
    extend ActionView::Helpers::FormHelper

    def submit_materialize(*args, &block)

      template.content_tag :div, class: "input-submit col s12" do
        options = args.extract_options!

        value = args[0] unless args[0].is_a?(Hash)
        value ||= submit_default_value

        button = template.content_tag(:button, class: options[:class], type: 'submit') do
          template.concat value
          template.concat icon
        end

        # with cancel link
        if cancel = options.delete(:cancel)
          button = cancel_link(cancel) +  button
        end

        button
      end

    end

    def cancel_link(path)
     template.link_to(I18n.t('simple_form.buttons.cancel'), path, class: 'waves-effect waves-light btn right btn-cancel')
    end

    def icon
      "<i class='mdi-content-send right'></i>".html_safe
    end
end

SimpleForm::FormBuilder.send :include, ButtonComponents
