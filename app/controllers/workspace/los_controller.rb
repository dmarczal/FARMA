class Workspace::LosController < Workspace::DashboardController
  include FindModels

  before_action :find_lo, only: [:show, :edit, :update, :destroy]

  def index
    @los = current_user.los.order :name
  end

  def show
    @contents = @lo.contents
  end

  def new 
    @lo = current_user.los.new
  end

  def create #create new lo (post)
    @lo = current_user.los.new(lo_params)
    if @lo.save
      redirect_to workspace_los_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def update # (put)
    if @lo.update(lo_params)
      redirect_to workspace_los_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def destroy # delete lo
    @lo.destroy
    redirect_to workspace_los_path
  end

  private
    def lo_params
      params.require(:lo).permit(:name, :description)
    end
end
