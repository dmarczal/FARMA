class Student::TeamsController < Student::StudentApplicationController
  add_breadcrumb 'Turmas', :student_teams_path

  def index
    @registered_teams = current_user.teams.where(opened: true)
    @open_teams = Team.opened_and_not_registered(current_user)
    @close_teams = current_user.teams.where(opened: false)
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
    @teams = current_user.teams.all.includes :user
  end

  private
    def params_to_register
      params.require(:register).permit(:code, :id)
    end
end
