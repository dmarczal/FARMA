module ViewLo::LosHelper
  def link_to_unless_current_page(url, &block)
    return link_to(capture(&block), url) unless current_page?(url)

    capture(&block)
  end
end
