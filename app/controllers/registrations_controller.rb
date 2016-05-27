class RegistrationsController < Devise::RegistrationsController

  protected
    def after_update_path_for(resource)
      teacher_path
    end
end
