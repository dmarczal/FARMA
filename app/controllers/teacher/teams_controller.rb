class Teacher::TeamsController < Teacher::ApplicationController
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
  end

  def create
    @team = current_user.my_teams.new team_params

    if @team.save
      flash.now[:notice] = "Questão #{@team.name} criada."
      redirect_to teacher_teams_path
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def list_add_los
    @team = current_user.my_teams.find params[:team_id]
    @los = current_user.los.all
  end

  def add_los
    team = current_user.my_teams.find params[:team_id]
    team.add_los params[:los]
  end

  private

  def team_params
    params.require(:team).permit(:name, :code)
  end
end
