class Teacher::TestController < Teacher::TeacherApplicationController
  include FindModels

  layout "lo/application"

  before_action :find_lo, only: [:show, :edit, :update, :destroy, :test]

  def test
    cookies.delete :answers
    @page = params[:page]
  end
end
