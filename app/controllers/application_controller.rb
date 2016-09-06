class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    resource.is_a?(Admin) ? admin_path : choose_workspace_path
  end

  protected

    def layout_by_resource
      return "devise/users_options" if devise_controller?

      "application"
    end

   def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :name, :short_description, :biography, :password, :password_confirmation, :remember_me, :avatar) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar) }
    end
end
