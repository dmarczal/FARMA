class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource
    yield resource if block_given?

    resource.build_avatar
    respond_with resource
  end

  protected
  def after_update_path_for(resource)
    workspace_path
  end

  private
  def layout_by_resource
    return "layouts/devise/session" if (action_name == 'new' || action_name == 'create')

    "layouts/#{current_area}/application"
  end
end
