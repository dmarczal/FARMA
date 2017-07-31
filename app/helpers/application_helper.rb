module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '', base_title = 'Farma')
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def truncate_and_set_tooltip(text, options = { length: 10 } )
    text_truncated = truncate(text, options)
    if text_truncated.eql?(text)
      return content_tag :p do text end
    else
      return content_tag :p, class: 'tooltipped',
                            'data-position' => 'bottom',
                            'data-tooltip' => text do
              text_truncated
             end
    end
  end

  def truncate_and_set_popup(title, text, options = { length: 200 } )
    text_truncated = truncate(text, options)

    if text_truncated.eql?(text)
      return content_tag :p do text end
    else
      id = Digest::SHA1.hexdigest(Time.now.to_s + title + text)
      link_plus = link_to(' mais...', "#modal-#{id}", class: 'modal-trigger')

      modal = content_tag :div, id: "modal-#{id}", class: 'modal' do
        tags = content_tag :div, class: 'modal-content' do
          content_tag :h4 do title end
          content_tag :p do text   end
        end
        tags += content_tag :div, class: 'modal-footer' do
          link_to('Fechar', '#!', class: 'modal-action modal-close waves-effect waves-green btn-flat')
        end
        tags
      end
      script = javascript_tag("$('body').prepend('#{j(modal)}')" );
      return text_truncated + ' ' + link_plus + script
    end
  end

  def namespace_name
    path = controller_path.split('/')
    path.second ? path.first : nil
  end

  def switch_workspace_checked_when_student
    return 'checked' if namespace_name.eql?('student')
  end

  def split_in_columns(**options, &block)
    collection = options[:collection]
    return if collection.nil?

    per_row = options[:per_row]

    css_class = "col s#{12/per_row}"
    html = ""

    collection.each_with_index do |obj, index|
      if ((index+1 % per_row) == 0)
        html += content_tag(:div, class: 'row') do
          content_tag(:div, class: css_class) do
            block.call(obj)
          end
        end
      else
        html += content_tag(:div, class: css_class) do
          block.call(obj)
        end
      end
    end

    raw(html)
  end
end
