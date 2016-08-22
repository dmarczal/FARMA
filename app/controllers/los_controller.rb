class LosController < ApplicationController
  def index
    @los = Lo.all
  end

  def page
    lo = Lo.find params[:id]
    @contents = @lo.contents
  end
end
