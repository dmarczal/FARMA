class HomeController < ApplicationController
  def index
    @contact = Contact.new
    @developers = Admin::Developer.where(active: true)
  end

end
