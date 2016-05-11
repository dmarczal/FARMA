module FindModels extend ActiveSupport::Concern
  
  private
    def find_lo
      @lo = current_user.los.find(lo_id_param)
    end

    def find_exercise
      find_lo
      @exercise = @lo.exercises.find(exercise_id_param)
    end

    def find_question
      find_exercise
      @question = @exercise.questions.find(question_id_param)
    end

    def lo_id_param
      self.is_a?(Teacher::LosController) ? params[:id] : params[:lo_id]
    end

    def exercise_id_param
      self.is_a?(Teacher::ExercisesController) ? params[:id] : params[:exercise_id]
    end

    def question_id_param
      self.is_a?(Teacher::QuestionsController) ? params[:id] : params[:question_id]
    end
end
