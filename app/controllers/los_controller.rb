class LosController < ApplicationController
  layout "public/application"

  def index
    @los = Lo.all
  end
end
