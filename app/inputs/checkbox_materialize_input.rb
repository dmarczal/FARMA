# <div>
#  <input type="checkbox" class="filled-in" id="filled-in-box" checked="checked" />
#  <label for="filled-in-box">Filled in</label>
# <div>
class CheckboxMaterializeInput < SimpleForm::Inputs::Base

  def input(wrapper_options)
    template.content_tag(:p, {class: 'checkbox-wrapper'}) do
      template.concat @builder.input_field(attribute_name, {type: :checkbox, class: 'filled-in'})
      template.concat label_tag
    end
  end

  def label_tag
    @builder.label(attribute_name)
  end

end
