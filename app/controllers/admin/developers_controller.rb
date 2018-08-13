class Admin::DevelopersController < Admin::AdminApplicationController
  before_action :set_developer, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t "developers", :admin_developers_path

  def index
    @developers = Admin::Developer.all
  end

  def new
    add_breadcrumb "Novo Desenvolvedor", new_admin_developer_path

    @developer = Admin::Developer.new
  end

  def create
    add_breadcrumb "Novo Desenvolvedor", new_admin_developer_path

    @developer = Admin::Developer.new(developer_params)
    if @developer.save
      flash.now[:success] = 'Desenvolvedor adicionado com sucesso.'
      redirect_to admin_developer_path(@developer)
    else
      flash.now[:error] = 'Existem dados incorretos.'
      render new_admin_developer_path
    end
  end

  def edit
    add_breadcrumb "Editando #{@developer.name}", edit_admin_developer_path(@developer)
  end

  def update
    add_breadcrumb "Editando #{@developer.name}", edit_admin_developer_path(@developer)

    if @developer.update(developer_params)
      flash.now[:success] = 'Desenvolvedor editado com sucesso.'
      redirect_to admin_developers_path
    else
      flash.now[:error] = 'Existem dados incorretos.'
      render :edit
    end
  end

  def show
    add_breadcrumb "Desenvolvedor #{@developer.name}", admin_developer_path(@developer)

    @developer
  end

  def destroy
    if @developer.destroy
      flash[:success] = 'Desenvolvedor excluido com sucesso.'
      redirect_to admin_developers_path
    else
      flash[:error] = 'Desenvolvedor não pode ser excluido'
      redirect_to admin_developers_path
    end
  end

  private
  def set_developer
    @developer = Admin::Developer.find(params[:id])
  end

  def developer_params
    params.require(:admin_developer).permit(:name, :function, :institution,
      :link, :start_on_project,
      :leave_project, :active,
      :profile_image)
    end
  end
