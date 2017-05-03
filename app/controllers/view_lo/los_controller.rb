class ViewLo::LosController < ViewLo::ApplicationController

  def page
    @team = Team.find params[:team_id]
    @lo = @team.los.find params[:lo_id]
    @lo_progress = Progress::Lo.find_or_create_by team_id: @team.id, lo_id: @lo.id, user_id: current_user.id
    @content = @lo.content_by_position params[:page]

    @lo_progress.recalc

    if @content.is_a? Introduction
      @lo_progress.previewed_an_introduction @content
    end

    @contents = @lo.contents
  end
end
