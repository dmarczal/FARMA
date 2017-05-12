class Student::StudentApplicationController < ::ApplicationController
  layout "student/application"
  before_action :authenticate_user!
  before_action :area=

  add_breadcrumb 'Início', :student_path

  protected

  def area=
    cookies[:farma_area] = "student"
  end
end
