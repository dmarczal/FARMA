class Student::LosController < Student::StudentApplicationController
  before_action :set_team

  layout "view_lo/los"

  def show
    @lo = @team.los.find params[:id]
    @page = params[:page].to_i
  end

  private

  def set_team
    @team = current_user.teams.find params[:team_id]
  end

end
