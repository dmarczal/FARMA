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
    @los = current_user.los.all
  end

  def create
    data = team_params
    los = data.delete(:los)
    @team = current_user.my_teams.new data

    if @team.save
      flash.now[:notice] = "Questão #{@team.name} criada."

      unless los.nil?
        los.each do |lo|
          @team.los_teams.new(lo_id: lo).save
        end
      end

      redirect_to teacher_teams_path
    else
      flash.now[:error] = "Existem dados incorretos."
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
    params.require(:team).permit(:name, :code, los: [])
  end
end
