class Student::LosController < Student::StudentApplicationController
  before_action :set_team

  layout "lo/application"

  def show
  end

  private

  def set_team
    @team = current_user.teams.find params[:team_id]
  end
end
