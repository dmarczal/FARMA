class ViewLo::LosController < ViewLo::ApplicationController

  def page
    @lo = Lo.find params[:lo_id]
    @content = @lo.content_by_position params[:page]
    @contents = @lo.contents
  end
end
