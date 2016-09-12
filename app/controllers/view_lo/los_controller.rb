class ViewLo::LosController < ViewLo::ApplicationController

  def page
    @content = current_lo.content_by_position params[:page]
    @contents = current_lo.contents
  end
end
