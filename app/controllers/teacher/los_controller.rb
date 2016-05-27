class Teacher::LosController < Teacher::ApplicationController
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

  def create #create new lo (post)
    @lo = current_user.los.new(lo_params)
    if @lo.save
      redirect_to teacher_los_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def update # (put)
    if @lo.update(lo_params)
      redirect_to teacher_los_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def destroy # delete lo
    @lo.destroy
    redirect_to teacher_los_path
  end

  private
    def lo_params
      params.require(:lo).permit(:name, :description, :image)
    end
end
