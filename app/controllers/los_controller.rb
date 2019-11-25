class LosController < ApplicationController
  layout "public/application"

  def index
    page = params[:page] || 1
    @query = params[:query]
    @los = los.order(:name).page(page)
  end

  private

  def los
    return Lo.available.find_with_like(params[:query]) if !params[:query].nil?
    Lo.available
  end
end
