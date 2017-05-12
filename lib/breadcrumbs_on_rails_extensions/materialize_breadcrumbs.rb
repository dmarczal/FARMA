#http://materializecss.com/breadcrumbs.html
#https://docs.omniref.com/ruby/gems/breadcrumbs_on_rails/0.1.1/symbols/BreadcrumbsOnRails::Breadcrumbs::SimpleBuilder

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
    name = compute_name element
    name_truncated = @context.truncate name, length: 25
    class_options = 'breadcrumb' + (name_truncated.eql?(name) ? '' : ' tooltipped')

    if current
      content = @context.content_tag :span, class: class_options,
                                            'data-position' => 'bottom',
                                            'data-tooltip' => name do
        name_truncated
      end
    else
      content = @context.link_to name_truncated, compute_path(element),
                                 class: class_options,
                                 'data-position' => 'bottom', 'data-tooltip' => 'name'
    end

    content
  end
end
