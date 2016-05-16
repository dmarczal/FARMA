module Teacher::LosHelper

  def current_link lo, content
    content.is_a?(Introduction) ? edit_teacher_lo_introduction_path(lo, content) :
                                  edit_teacher_lo_exercise_path(lo, content)
  end
  
end
