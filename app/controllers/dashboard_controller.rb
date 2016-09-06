class DashboardController < Devise::SessionsController
  before_action :authenticate_admin!
end
