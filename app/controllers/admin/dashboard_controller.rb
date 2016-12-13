class Admin::DashboardController < Admin::ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.order :name
  end

  layout 'layouts/admin/application'

end
