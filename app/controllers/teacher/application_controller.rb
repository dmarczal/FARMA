class Teacher::ApplicationController < ::ActionController::Base
  layout "teacher/application"
  before_action :authenticate_user!

  add_breadcrumb "Home", :teacher_path
  
end
