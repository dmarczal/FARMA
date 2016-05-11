module Teacher::LosHelper

  def correct_link(lo, content)
    return  content.is_a?(Introduction) ? edit_teacher_lo_introduction_path(lo, content) :
                                          edit_teacher_lo_exercise_path(lo, content)
  end
end
