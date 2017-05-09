class Teacher::TeacherApplicationController < ::ApplicationController
  layout "teacher/application"
  before_action :authenticate_user!
  before_action :page_title
  before_action :area=

  helper_method :breadcrumb_name, :breadcrumb_path

  add_breadcrumb 'Início', :teacher_path
  add_breadcrumb 'Meus OAs', :teacher_los_path, if: :los_or_exercises_or_introductions_controller?
  add_breadcrumb :breadcrumb_name, :breadcrumb_path, if: :exercises_or_introductions_controller?

  protected
    def page_title
      @title = self.is_a?(Teacher::DashboardController) ? "home" : "Meus Objetos de Aprendizagem"
    end

    def los_or_exercises_or_introductions_controller?
      self.is_a?(Teacher::LosController) ||
      self.is_a?(Teacher::ExercisesController) ||
      self.is_a?(Teacher::IntroductionsController)
    end

    def exercises_or_introductions_controller?
      self.is_a?(Teacher::ExercisesController) || self.is_a?(Teacher::IntroductionsController)
    end

    def breadcrumb_name
      lo = find_lo
      "OA #{lo.name}"
    end

    def breadcrumb_path
      lo = find_lo
      teacher_lo_path(lo)
    end

    def area=
      cookies[:farma_area] = "teacher"
    end
end
