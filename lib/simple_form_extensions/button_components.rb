# https://gist.github.com/maxivak/57a2fb71afeb9efcf771
module ButtonComponents
    extend ActionView::Helpers::FormHelper

    def submit_materialize(*args, &block)

      template.content_tag :div, class: "input-submit col s12 m8 offset-m4 right-align" do
        options = args.extract_options!

        value = args[0] unless args[0].is_a?(Hash)
        value ||= submit_default_value

        button = template.content_tag(:button, class: options[:class], type: 'submit') do
          template.concat value
          template.concat icon 'send'
        end

        # with cancel link
        if cancel = options.delete(:cancel)
          button = cancel_link(cancel) + button
        end

        button
      end

    end

    def cancel_link path
     template.link_to path, class: "btn-cancel " do
       template.concat icon 'clear'
     end
    end

    def icon icon_name
      "<i class='material-icons right'>#{icon_name}</i>".html_safe
    end
end

SimpleForm::FormBuilder.send :include, ButtonComponents
