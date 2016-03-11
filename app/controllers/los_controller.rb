class LosController < DashboardController
  before_action :find_lo , only: [:show, :edit, :update, :destroy]
  # get of lo
  def index
    @los = current_user.los.order :name
  end

  def show
    @introductions = @lo.introduction.order :title
  end

  # edition of lo
  def new # new lo
    @lo = current_user.los.new
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

  def update #edit lo (put)

    if @lo.update(lo_params)
      redirect_to los_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render 'edit'
    end
  end

  def destroy #delete lo
    @lo.destroy
    redirect_to los_path
  end

  private
    def lo_params
      params.require(:lo).permit(:name, :description)
    end

    def find_lo
      @lo = current_user.los.find(params[:id])
    end
end
