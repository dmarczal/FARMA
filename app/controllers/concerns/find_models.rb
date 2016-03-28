module FindModels extend ActiveSupport::Concern
  protected
    def find_lo id
      @lo = current_user.los.find(id)
    end

    def find_exercise(id, lo_id)
      find_lo lo_id
      @exercise = @lo.exercise.find(id)
    end
end
