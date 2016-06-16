module FindModels extend ActiveSupport::Concern

  private
    def find_lo
      @lo ||= current_user.los.find(lo_id_param)
    end

    def find_exercise
      find_lo
      @exercise ||= @lo.exercises.find(exercise_id_param)
    end

    def find_question
      find_exercise
      @question ||= @exercise.questions.find(question_id_param)
    end

    def lo_id_param
      params[:lo_id] ? params[:lo_id] : params[:id]
    end

    def exercise_id_param
      params[:exercise_id] ? params[:exercise_id] : params[:id]
    end

    def question_id_param
       params[:question_id] ?  params[:question_id] : params[:id]
    end
end
