class LosController < DashboardController

  # demonstration of lo
  def index
    @los = Lo.order :name
  end

  def my
    @los = current_user.los.order :name
  end

  def show
    @lo = Lo.find(params[:id])
  end

  # edition of lo
  def new
    @lo = current_user.los.new
  end

  def edit
    @lo = current_user.los.find(params[:id])
  end

  def update
    @lo = current_user.los.find(params[:id])

    if @lo.update(lo_params)
      redirect_to los_my_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render 'edit'
    end
  end

  def destroy
    @lo = current_user.los.find(params[:id])
    @lo.destroy

    redirect_to los_my_path
  end

  def create
    @lo = current_user.los.new(lo_params)

    if @lo.save
      redirect_to los_my_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render 'new'
    end
  end

  private
    def lo_params
      params.require(:lo).permit(:name, :description)
    end
end
