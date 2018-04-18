class Admin::DevelopersController < Admin::AdminApplicationController

  before_action :set_developer, only: [:show, :edit, :update, :destroy]

  def index
    @developers = Admin::Developer.all.order(active: :desc).order(:start_on_project)
  end

  def new
  	@developer = Admin::Developer.new
  end

  def create
    @developer = Admin::Developer.new(developer_params)
    
    if @developer.save
      flash.now[:success] = "Desenvolvedor adicionado com sucesso."
    	redirect_to admin_developer_path(@developer) 
    else
      flash.now[:error] = "Existem dados incorretos."
      render new_admin_developer_path
    end
  end

  def edit
    
  end

  def update
    if @developer.update(developer_params)
      flash.now[:success] = "Desenvolvedor editado com sucesso."
      render :show
    else
      flash.now[:error] = "Existem dados incorretos."
      render edit_admin_developer_path
    end
  end

  def show
    @developer
  end

  def destroy
    @developer.destroy
    flash[:error] = "Desenvolvedor excluido com sucesso."
    redirect_to admin_developers_path
  end

  private

  def set_developer
    @developer = Admin::Developer.find(params[:id])    
  end  

  def developer_params
  	params.require(:admin_developer).permit(:name, :function, :institution, :link, :start_on_project, :leave_project, :active, :profile_image)
  end

end
