class LosController < DashboardController

  def index
    @los = Lo.all
  end

end
