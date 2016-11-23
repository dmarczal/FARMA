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
end
