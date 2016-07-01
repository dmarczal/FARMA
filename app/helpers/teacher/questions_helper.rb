module Teacher::QuestionsHelper

  def ckeditor_id(object)
    object.id.nil? ? "ckeditor_new_question" : "ckeditor_question_#{object.id}"
  end
end
