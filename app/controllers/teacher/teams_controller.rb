class Teacher::TeamsController < Teacher::TeacherApplicationController
  add_breadcrumb 'Minhas Turmas', :teacher_teams_path

  def index
    @teams = current_user.my_teams.all
  end

  def show
    @team = current_user.my_teams.find params[:id]
    add_breadcrumb "Turma #{@team.name}", teacher_team_path(@team)
  end

  def new
    @team = current_user.my_teams.new
    @team.build_image
    @los = current_user.los.all
  end

  def create
    team_service = Teacher::TeamService.new()
    team_service.build_team team_params, current_user

    if team_service.save_team
      flash[:notice] = "Turma #{team_service.team.name} criada."
      redirect_to teacher_team_path(team_service.team)
    else
      flash.now[:error] = "Erro ao criar a turma"
      @team = team_service.team
      @los = current_user.los.all
      render :new
    end
  end

  def destroy
    @team = current_user.my_teams.find params[:id]
    @team.destroy

    redirect_to teacher_teams_path
  end

  private
  def team_params
    params.require(:team).permit(:name, :code, los: [], image_attributes: [:image])
  end
end
