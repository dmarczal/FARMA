class Student::StudentApplicationController < ::ApplicationController
  layout "student/application"
  before_action :authenticate_user!
  before_action :area=

  protected

  def area=
    cookies[:farma_area] = "student"
  end
end
