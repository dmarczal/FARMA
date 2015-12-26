class Admin::DashboardController < Admin::ApplicationController

  def index
    @users = User.order :name
  end

end
