class ViewLo::LosController < ViewLo::ApplicationController

  def page
    @team = Team.find params[:team_id]
    @lo = @team.los.find params[:lo_id]
    @content = @lo.content_by_position params[:page]
    @contents = @lo.contents
  end
end
