# <div>
#  <input type="checkbox" class="filled-in" id="filled-in-box" checked="checked" />
#  <label for="filled-in-box">Filled in</label>
# <div>

# <p>
#   <label>
#     <input type="checkbox" />
#     <span>Red</span>
#   </label>
# </p>
class CheckboxMaterializeInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag :p do
      object = @builder.object

      check_box = @builder.label(attribute_name) do
        label = template.content_tag :span, object.class.human_attribute_name(attribute_name)
        @builder.check_box(attribute_name, {class: 'filled-in'}).concat label
      end

      template.concat check_box
    end
  end
end
