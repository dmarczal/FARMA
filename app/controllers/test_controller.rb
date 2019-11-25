class TestController < ApplicationController
  layout "lo/application"

  def show
    cookies.delete :answers
    @lo = Lo.find params[:id]
  end
end
