class LosController < ApplicationController
  def index
    @contact = Contact.new
    @los = Lo.all
  end
end
