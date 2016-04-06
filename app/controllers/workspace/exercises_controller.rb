class Workspace::ExercisesController < Workspace::DashboardController
  include FindModels

  before_action :find_lo, only: [:new, :create]
  before_action :find_exercise, except: [:new, :create]

  def show
    @questions = @exercise.questions.all
  end

  def new
    @exercise = @lo.exercises.new
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to workspace_lo_path(@lo)
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def create
    @exercise = @lo.exercises.new(exercise_params)
    if @exercise.save
      redirect_to workspace_lo_path(@lo)
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def destroy
    @exercise.destroy
    redirect_to workspace_lo_path(@lo)
  end

  private
    def exercise_params
      params.require(:exercise).permit(:title, :content)
    end

end
