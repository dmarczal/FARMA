class API::TeamsController < API::ApplicationController
  def show
    team = current_user.teams.find params[:id]
    lo = team.lo
    service = Student::LoService.new team,
                                     current_user,
                                     lo,
                                     params[:page].to_i

    self.data_type = 'Content[]'
    self.status_response = :ok
    self.data = service.data

    json_response
  end
end
