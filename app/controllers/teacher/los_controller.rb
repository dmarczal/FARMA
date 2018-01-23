class Teacher::LosController < Teacher::TeacherApplicationController
  include FindModels

  before_action :find_lo, only: [:show, :edit, :update, :destroy]

  def index
    @los = current_user.los.order :name
  end

  def show
    add_breadcrumb "OA #{@lo.name}", teacher_lo_path(@lo)
    
    @contents = @lo.contents
  end

  def new
    add_breadcrumb "Novo OA", new_teacher_lo_path

    @lo = current_user.los.new
  end

  def edit
    add_breadcrumb "Editar #{@lo.name}", edit_teacher_lo_path(@lo)
  end

  def create
    @lo = current_user.los.new(lo_params)

    if @lo.save
      redirect_to teacher_lo_path(@lo), flash: { success: 'OA criado com sucesso.' }
    else
      flash.now[:error] = 'Existem dados incorretos.'
      render :new
    end
  end

  def update
    if @lo.update(lo_params)
      redirect_to teacher_los_path, flash: { success: 'OA editado com sucesso.' }
    else
      flash.now[:error] = 'Existem dados incorretos.'
      render :edit
    end
  end

  def destroy
    if @lo.destroy
      redirect_to teacher_los_path, flash: { success: 'Oa excluído com sucesso' }
    else 
      redirect_to teacher_los_path, flash: { error: 'Esse Oa está em uma turma' }
    end
  end

  private

  def lo_params
    params.require(:lo).permit(:name, :description, :image)
  end
end
