module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '', base_title = 'Farma')
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def page_title_the_teacher page_title = '', base_title = 'Meus Objetos de Aprendizagem'
    page_title.empty? ? base_title : page_title 
  end

end
