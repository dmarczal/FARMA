class Teacher::IntroductionsController < Teacher::TeacherApplicationController
  include FindModels

  before_action :find_lo, only: [:new, :create]
  before_action :find_introduction, except: [:new, :create]

  def new
    add_breadcrumb "Nova Introdução", new_teacher_lo_introduction_path(@lo)

    @introduction = @lo.introductions.new
  end

  def edit
    add_breadcrumb "Editar Introdução", new_teacher_lo_introduction_path(@lo, @title)
  end

  def create
    @introduction = @lo.introductions.new(introduction_params)
    if @introduction.save
      redirect_to [:teacher, @lo], flash: { success: 'Introdução criada com sucesso.' }
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def update
    if @introduction.update(introduction_params)
      redirect_to [:teacher, @lo, @introduction], flash: { success: 'Introdução editada com sucesso.' }
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def destroy
    @introduction.destroy
    redirect_to teacher_lo_path(@lo)
  end

  private

  def introduction_params
    params.require(:introduction).permit(:title, :content)
  end

  def find_introduction
    find_lo
    @introduction = @lo.introductions.find(params[:id])
  end
end
