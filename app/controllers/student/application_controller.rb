class Student::ApplicationController < ::ActionController::Base
  layout "student/application"
  before_action :authenticate_user!


end
