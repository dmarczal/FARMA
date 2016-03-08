class IntroductionsController < LosController
  before_action :find_lo , only: [:new, :create, :destroy]
  before_action :find_introduction, only: [:destroy]

  def new
    @introduction = @lo.introduction.new
  end

  def create
    @introduction = @lo.introduction.new(introduction_params)
    if @introduction.save
      redirect_to @lo
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new

    end
  end

  def destroy
    @introduction.destroy
    redirect_to @lo
  end

  private
    def introduction_params
      params.require(:introduction).permit(:title, :content)
    end

    def find_lo
      @lo = current_user.los.find(params[:lo_id])
    end

    def find_introduction
      @introduction = @lo.introduction.find(params[:id])
    end
end
