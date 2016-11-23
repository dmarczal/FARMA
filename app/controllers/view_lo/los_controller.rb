class ViewLo::LosController < ViewLo::ApplicationController

  def page
    @team = Team.find params[:team_id]
    @lo = @team.los.find params[:lo_id]
    @content = @lo.content_by_position params[:page]
    @contents = @lo.contents
    @percent_process_bar = "30"
    @percent_preview_bar = "50"
  end
end
