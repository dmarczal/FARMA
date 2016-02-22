
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
    out = ActiveSupport::SafeBuffer.new # the output buffer we're going to build

    template.content_tag(:div, {class: 'file-field input-field'}) do

      out << template.content_tag(:div, {class: 'btn'}) do
        template.concat label_name
        template.concat btn_tag
      end

      out << template.content_tag(:div, {class: 'file-path-wrapper'}) do
        template.concat file_path
      end

      out
    end
  end

  def label(wrapper_options)
    ""
  end

  def btn_tag
    @builder.file_field(attribute_name)
  end

  def label_name
    translated_name = object.class.human_attribute_name(attribute_name)
    "<span>#{translated_name}</span>".html_safe
  end

  def file_path
    @builder.text_field(attribute_name, {class: 'file-path validate'})
>>>>>>> remotes/farma-reborned/farma/master
  end

end
