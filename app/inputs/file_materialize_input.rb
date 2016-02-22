#<div class="file-field input-field">
#      <div class="btn">
#        <span>File</span>
#        <input type="file">
#      </div>
#      <div class="file-path-wrapper">
#        <input class="file-path validate" type="text">
#      </div>
#</div>
# To use: <%= f.input :image, as: :file_materialize %>
class FileMaterializeInput < SimpleForm::Inputs::Base

  def input(wrapper_options)

    template.content_tag(:div, {class: 'file-field input-field'}) do
      template.concat button_file
      template.concat text_file
    end

  end

  def label
    ''
  end

  def button_file
    template.content_tag(:div, {class: 'btn'}) do
      template.concat span_tag
      template.concat @builder.input_field(attribute_name, type: :file)
    end
  end

  def text_file
    puts @builder.methods
    template.content_tag(:div, {class: 'file-path-wrapper'}) do
      template.concat "<input class=\"file optional file-path validate\" id=\"user_avatar_text_file\" type=\"text\">".html_safe
    end
  end

  def span_tag
    translated_name = object.class.human_attribute_name(attribute_name)
    template.content_tag(:span) do
      translated_name
    end
  end

end
