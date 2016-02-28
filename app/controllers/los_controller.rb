class LosController < ApplicationController
  layout "dashboard/application"

  def index
    @los = Lo.all.order :name
  end

  def new
    @los = Lo.new
  end

  def destroy
    @los = Lo.find(params[:id])
    @los.destroy

    redirect_to los_path
  end

  def create
    @los = Lo.new(los_params)
    @los.user_id = current_user.id
    if @los.save
      redirect_to los_path
    else
      # flash.now[:error] = "Existem dados incorretos."
      redirect_to new_lo_path
    end
  end

  private
    def los_params
      params.require(:lo).permit(:name, :description)
    end

end
