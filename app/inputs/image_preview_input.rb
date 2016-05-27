#https://github.com/plataformatec/simple_form/wiki/Adding-custom-input-components

class ImagePreviewInput < SimpleForm::Inputs::FileInput

  def input(wrapper_options = nil)

    template.content_tag :div, class: 'box-image center' do
      if object.send("#{attribute_name}?")
        template.concat image_preview
      else
        template.concat image_preview
        template.concat text_box
      end
      template.concat @builder.input_field(attribute_name, type: :file)
    end

  end

  def label
    ''
  end

  def image_preview
    if object.send("#{attribute_name}?")
      template.image_tag(object.send("#{attribute_name}"), :class => 'file_preview active') if object.send("#{attribute_name}?")
    else
      template.image_tag('', :class => 'file_preview')
    end
  end

  def text_box
    template.content_tag :div, class: 'text-box' do
      template.concat icon_tag
      template.concat text_tag
    end
  end

  def icon_tag
    template.content_tag :i, class: 'icon-input-image material-icons' do
      'panorama'
    end
  end

  def text_tag
    template.content_tag :p, class: 'text-input center' do
      'Clique aqui para adicionar uma imagem'
    end
  end

end
