module FindModels extend ActiveSupport::Concern
  private
    def find_lo
      @lo = current_user.los.find(lo_id_param)
    end

    def find_exercise
      find_lo
      @exercise = @lo.exercises.find(exercise_id_param)
    end

    def lo_id_param
      self.is_a?(Workspace::LosController) ? params[:id] : params[:lo_id]
    end

    def exercise_id_param
      self.is_a?(Workspace::ExercisesController) ? params[:id] : params[:exercise_id]
    end
end
