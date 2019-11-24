class Teacher::TeamsController < Teacher::TeacherApplicationController
  add_breadcrumb 'Minhas Turmas', :teacher_teams_path

  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = current_user.my_teams.all
  end

  def show
    add_breadcrumb "Turma #{@team.name}", teacher_team_path(@team)
  end

  def time_line
    @team = current_user.my_teams.find params[:team_id]
    add_breadcrumb "Turma #{@team.name}", teacher_team_path(@team)
    add_breadcrumb "Linha do tempo de Jefferson", teacher_team_time_line_path(@team)
  end

  def new
    @team = current_user.my_teams.new
    @team.build_image
    @los = current_user.los.all
  end

  def edit
    @team.build_image if @team.image.nil?
    @los = current_user.los.all
  end

  def create
    @team = current_user.my_teams.new team_params

    if @team.save
      flash[:notice] = "Turma #{@team.name} criada."
      redirect_to teacher_team_path(@team)
    else
      @los = current_user.los.all
      @team.build_image
      flash.now[:error] = "Erro ao criar a turma"
      render :new
    end
  end

  def update
    if @team.update team_params
      flash[:notice] = "Turma #{@team.name} editada."
      redirect_to teacher_team_path(@team)
    else
      @los = current_user.los.all
      @team.build_image if @team.image.nil?
      flash.now[:error] = "Erro ao editar a turma"
      render :edit
    end
  end

  def destroy
    @team.destroy

    redirect_to teacher_teams_path
  end

  private
  def team_params
    params.require(:team).permit :name,
                                 :code,
                                 :lo_id,
                                 :opened,
                                 image_attributes: [:image]
  end

  def set_team
    @team = current_user.my_teams.find params[:id]
  end
end
