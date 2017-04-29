class Student::StudentApplicationController < ::ApplicationController
  layout "student/application"
  before_action :authenticate_user!

end
