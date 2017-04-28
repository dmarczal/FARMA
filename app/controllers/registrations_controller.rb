class RegistrationsController < Devise::RegistrationsController

  protected
  def after_update_path_for(resource)
    workspace_path
  end

  private
  def layout_by_resource
    return "layouts/devise/session" if (action_name == 'new' || action_name == 'create')

    last_module = /[a-zA-Z0-9]\/(.*)/.match(request.referer)
    last_module = last_module.nil? ? '' : last_module[1]

    if action_name == 'edit'
      "#{last_module}/application"
    end
  end
end
