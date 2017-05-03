class MultSelectInput < SimpleForm::Inputs::Base

  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:id] = "#{@builder.object_name}_#{attribute_name}"
    merged_input_options[:name] = "#{@builder.object_name}[#{attribute_name}][]"
    merged_input_options[:multiple] = true
    collection = options.delete(:collection)
    label = options.delete(:name)

    options = "<option value disabled selected>#{label}</option>"
    collection.each do |obj|
      options += "<option value=#{obj.id}>#{obj.name}</option>"
    end

    template.content_tag(:select, merged_input_options) do
      options.html_safe
    end
  end

  def label(wrapper_options)
    ''
  end
end
