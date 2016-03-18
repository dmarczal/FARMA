class Workspace::ExercisesController < Workspace::DashboardController
  before_action :find_lo , only: [:new, :create]
  before_action :find_exercise, only: [:destroy, :update, :show, :edit]

  def new
    @exercise = @lo.exercise.new
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to [:workspace, @lo]
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def create
    @exercise = @lo.exercise.new(exercise_params)
    if @exercise.save
      redirect_to [:workspace, @lo]
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def destroy
    @exercise.destroy
    redirect_to [:workspace, @lo]
  end

  private
    def exercise_params
      params.require(:exercise).permit(:title, :content)
    end

    def find_lo
      @lo = current_user.los.find(params[:lo_id])
    end

    def find_exercise
      find_lo
      @exercise = @lo.exercise.find(params[:id])
    end
end
