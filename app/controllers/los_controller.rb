class LosController < ApplicationController
  def index
    @los = Lo.all
  end
end
