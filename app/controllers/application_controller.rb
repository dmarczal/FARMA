class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    resource.is_a?(Admin) ? admin_path : workspace_path
  end

  def after_sign_out_path_for(resource)
     return new_admin_session_path if resource == :admin

     root_path
  end

protected

  def layout_by_resource
    return "devise/session" if devise_controller?

    "application"
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up) do |user_params|
     user_params.permit(:name, 
                        :email, 
                        :password, 
                        :password_confirmation, 
                        :remember_me,
                         avatar_attributes: [:image])
   end

   devise_parameter_sanitizer.permit(:account_update) do |user_params|
     user_params.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar)
   end
  end

  def current_area
    return 'teacher' if cookies[:farma_area].nil?

    cookies[:farma_area]
  end
end
