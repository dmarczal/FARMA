class Student::TeamsController < Student::StudentApplicationController

  def index
    add_breadcrumb 'Turmas Abertas', :student_teams_path
    @teams = Team.opened
  end

  def show
    @team = Team.find params[:id]
    @los = @team.los.all

    add_breadcrumb @team.name, student_team_path(@team)
  end

  def create
    if current_user.register params_to_register
      flash[:success] = "Registro feito."
      redirect_to student_team_path(params_to_register[:id])
    else
      flash[:error] = "Chave incorreta."
      redirect_to student_teams_path
    end
  end

  def registered
    add_breadcrumb 'Turmas Matriculadas', student_registered_teams_path

    @opened_teams = current_user.teams.opened
    @closed_teams = current_user.teams.closed
  end

  def find_teams
    @teams = Team.find_with_like(team.name).opened
    render json: @teams
  end

  private
    def params_to_register
      params.require(:register).permit(:code, :id)
    end
end
