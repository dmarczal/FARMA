class API::ApplicationController < ActionController::API
  include APIResponses
  include ActionController::Cookies

  protected

  def find_question
    @question = @exercise.questions.find(question_param)
  end

  def find_exercise
    @exercise = Exercise.find(exercise_param)
  end
end
