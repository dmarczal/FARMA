class Teacher::ExercisesController < Teacher::TeacherApplicationController
  include FindModels

  before_action :find_lo, only: [:new, :create]
  before_action :find_exercise, except: [:new, :create]

  def show
    add_breadcrumb "Passos do exercicio #{@exercise.title}", teacher_lo_exercise_path(@lo, @exercise)
  end

  def new
    add_breadcrumb "Novo Exercício", new_teacher_lo_exercise_path(@lo)

    @exercise = @lo.exercises.new
  end

  def create
    @exercise = @lo.exercises.new(exercise_params)
    if @exercise.save
      redirect_to [:teacher, @lo, @exercise], flash: { success: 'Exercício criado com sucesso.' }
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def edit
    add_breadcrumb "Editar Exercício", edit_teacher_lo_exercise_path(@lo, @exercise)
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to [:teacher, @lo, @exercise], flash: { success: 'Exercício editado com sucesso.' }
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to teacher_lo_path(@lo)
  end

  private
    def exercise_params
      params.require(:exercise).permit(:title, :content)
    end
end
