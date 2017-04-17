class Admin::DashboardController < Admin::AdminApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.order :name
  end

end
