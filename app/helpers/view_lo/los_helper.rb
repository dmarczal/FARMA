module ViewLo::LosHelper
  def link_to_unless_current_page(url, &block)
    unless current_page?(url)
      li = content_tag :li do
        link_to(capture(&block), url)
      end

      return li
    end

    content_tag :li, class: "active" do
      capture(&block)
    end
  end

  def exec_if_the_page_exists(list, page)
    return yield if page_exists?(list, page)
  end

  def page_exists?(list, page)
    page > 0 && page <= list.length
  end
end
