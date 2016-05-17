#http://materializecss.com/breadcrumbs.html

class MaterializeBreadcrumbs < BreadcrumbsOnRails::Breadcrumbs::Builder

  def render
    @context.content_tag :nav , class: @options[:class] do
      @context.content_tag :div, class: 'nav-wrapper' do
        @context.content_tag :div, class: 'col s12' do
          @elements.collect do |element|
            render_element element
          end.join.html_safe
        end
      end
    end
  end

  def render_element element
    current = @context.current_page?(compute_path(element))

    if current
      content = @context.content_tag :span, class: 'breadcrumb' do
        compute_name element
      end
    else
      content = @context.link_to compute_name(element), compute_path(element), class: 'breadcrumb'
    end

    content
  end
end
