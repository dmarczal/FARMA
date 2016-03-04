class LosController < DashboardController

  # demonstration of lo
  def index
    @los = current_user.los.order :name
  end

  def show
    @lo = Lo.find(params[:id])
  end

  # edition of lo
  def new # new lo
    @lo = current_user.los.new
  end

  def edit
    @lo = current_user.los.find(params[:id])
  end

  def update #edit lo (put)
    @lo = current_user.los.find(params[:id])

    if @lo.update(lo_params)
      redirect_to los_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render 'edit'
    end
  end

  def destroy #delete lo
    @lo = current_user.los.find(params[:id])
    @lo.destroy

    redirect_to los_path
  end

  def create #create new lo (post)
    @lo = current_user.los.new(lo_params)

    if @lo.save
      redirect_to los_path
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
