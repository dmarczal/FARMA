class HomeController < ApplicationController
  def index
    @contact = Contact.new
    @developers = Admin::Developer.actives
  end

end
